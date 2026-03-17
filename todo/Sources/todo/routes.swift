import Fluent
import Vapor

func routes(_ app: Application) throws {
    /*let todos = app.grouped("todos")
    
    todos.get("todos") { request in
        "Todos"
    }

    try app.register(collection: TodoController())*/
    
    try app.register(collection: UserController())
    
    let protected = app.grouped(UserPayload.authenticator(),
                                UserPayload.guardMiddleware()
    )
    
    try protected.register(collection: TodoController())
}
