import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    let userController = UserController()
    router.get("users", use: userController.list)
    router.post("users", use: userController.create)
    router.patch("users", User.parameter, use: userController.update)
    router.delete("users", User.parameter, use: userController.delete)
}
