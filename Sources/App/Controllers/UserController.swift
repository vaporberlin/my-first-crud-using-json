final class UserController {
  
  func list(_ req: Request) throws -> ResponseRepresentable {
    let list = try User.all()
    return try list.makeJSON()
  }
  
  func create(_ req: Request) throws -> ResponseRepresentable {
    guard let json = req.json else {
      return "missing json"
    }
    
    var user: User
    do { user = try User(json: json) }
    catch { return "could not initiate user with given json" }
    
    try user.save()
    return try user.makeJSON()
  }
  
  func update(_ req: Request) throws -> ResponseRepresentable {
    guard let userId = req.parameters["id"]?.int else {
      return "no user id provided"
    }
    
    guard let json = req.json else {
      return "missing json"
    }
    
    guard let user = try User.find(userId) else {
      return "could not find user with id \(userId)"
    }
    
    // set username if the field exists else reassign old value
    user.username = try json.get("username") ?? user.username
    
    try user.save()
    return try user.makeJSON()
  }
  
  func delete(_ req: Request) throws -> ResponseRepresentable {
    guard let userId = req.parameters["id"]?.int else {
      return "no user id provided"
    }
    
    guard let user = try User.find(userId) else {
      return "could not find user with id \(userId)"
    }
    
    try user.delete()
    return Response(status: .ok)
  }
}
