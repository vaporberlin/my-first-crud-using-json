import Vapor

final class UserController {

    // view with users
    func list(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }

    // create a new user
    func create(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).flatMap { user in
            return user.save(on: req)
        }
    }

    // update a user
    func update(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self).flatMap { user in
            return try req.content.decode(User.self).flatMap { newUser in
                user.username = newUser.username
                return user.save(on: req)
            }
        }
    }

    // delete a user
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self).flatMap { user in
            return user.delete(on: req)
        }.transform(to: .ok)
    }
}
