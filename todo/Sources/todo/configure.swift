import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "YOUR_DB_USERNAME",
        password: Environment.get("DATABASE_PASSWORD") ?? "",
        database: Environment.get("DATABASE_NAME") ?? "YOUR_DB_NAME",
        tls: .prefer(try .init(configuration: .clientDefault)))
                                                            
        // Eğer hata verirse
        //tls:.disable
    ), as: .psql)

    
    await app.jwt.keys.add(hmac: "YOUR_SECRET_KEY", digestAlgorithm: .sha256)
    
    app.migrations.add(CreateUser())
    app.migrations.add(CreateTodo())
    
    

    // register routes
    try routes(app)
}
