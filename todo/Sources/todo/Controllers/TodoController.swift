import Fluent
import Vapor
import Foundation

struct TodoController: RouteCollection, Sendable {
    func boot(routes: any RoutesBuilder) throws {
        let todos = routes.grouped("todos").grouped(UserPayload.authenticator(), UserPayload.guardMiddleware())
        
        
        // CREATE
        todos.post { request in
            try await createTodo(request: request)
        }
        // READ
        todos.get { request in
            try await getTodos(request: request)
        }
        
        todos.get(":id") { request in
            try await getTodo(request: request)
        }
        
        
        // UPDATE
        todos.put(":id"){ request in
             try await updateTodo(request: request)
        }
        
        // DELETE
        todos.delete(":id") { request in
             try await deleteTodo(request: request)
        }
        
    }
    
    // MARK: - Create

    private func createTodo(request: Request) async throws -> TodoResponseContent{
        
        let userPayload = try request.auth.require(UserPayload.self)
        
        let requestContent = try request.content.decode(TodoRequestContent.self)
        guard let title = requestContent.title else {
            throw Abort(.badRequest, reason: "Title is required")
        }
        
        let todo = Todo(requestContent: requestContent, title: title)
        
        
        todo.$user.id = userPayload.userID
        
        try await todo.create(on: request.db)
        
        return try await TodoResponseContent(todo: todo, user: todo.$user.get(reload: true, on: request.db))
    }
    
    // MARK: - Read
    private func getTodos(request: Request) async throws -> Page<TodoResponseContent>{
        
        let userPayload = try request.auth.require(UserPayload.self)
           

           let dateString = try? request.query.get(String.self, at: "date")
           
           let query = Todo.query(on: request.db)
               .filter(\.$user.$id == userPayload.userID)
               .with(\.$user)
           

           if let dateString = dateString {
               let formatter = DateFormatter()
               formatter.dateFormat = "yyyy-MM-dd"
               formatter.timeZone = TimeZone(abbreviation: "UTC")
               
               if let date = formatter.date(from: dateString) {

                   let start = Calendar.current.startOfDay(for: date)

                   let end = Calendar.current.date(byAdding: .day, value: 1, to: start)!
                   

                   query.group(.and) { group in
                       group.filter(\.$startDate >= start)
                            .filter(\.$startDate < end)
                   }
               }
           }
           
           return try await query.sort(\.$startDate, .ascending) // Tarihe göre de sıralayalım
               .paginate(for: request)
               .map { try TodoResponseContent(todo: $0, user: $0.user) }
        
    }
    
    
    private func getTodo(request: Request) async throws -> TodoResponseContent{
        let todo: Todo = try await findByID(request: request)
        
        let user = try await todo.$user.get(on: request.db)
        
        return try TodoResponseContent(todo: todo, user: user)
        
        
    }
    
    // MARK: - Update
    private func updateTodo(request: Request) async throws -> TodoResponseContent{
        let userPayload = try request.auth.require(UserPayload.self)
        let todo: Todo = try await findByID(request: request)
        
        guard todo.$user.id == userPayload.userID else{
            throw Abort(.forbidden, reason: "You can not view this note")
        }
        
        let requestContent = try request.content.decode(TodoRequestContent.self)
        
        todo.setValue(requestContent.title, to: \.title)
        todo.setValue(requestContent.description, to: \.description)
        todo.setValue(requestContent.startDate, to: \.startDate)
        todo.setValue(requestContent.endDate, to: \.endDate)
        todo.setValue(requestContent.isCompleted, to: \.isCompleted)
        
        try await todo.update(on: request.db)
        
        return try await TodoResponseContent(
            todo: todo,
            user: todo.$user.get(reload: true, on: request.db)
        )
        
    }
    
    // MARK: - Delete
    private func deleteTodo(request: Request) async throws -> HTTPStatus{
        
        let userPayload = try request.auth.require(UserPayload.self)
        
        guard let todo = try await Todo.find(request.parameters.get("id"), on: request.db) else {
                throw Abort(.notFound)
            }
        
        
        guard todo.$user.id == userPayload.userID else {
                throw Abort(.forbidden)
            }
        
        try await todo.delete(on: request.db)
        return .noContent
    }
}
