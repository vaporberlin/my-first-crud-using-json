import Vapor
import FluentProvider

final class User: Model {
  var storage = Storage()
  var username: String
  
  init(username: String) {
    self.username = username
  }
  
  func makeRow() throws -> Row {
    var row = Row()
    try row.set("username", username)
    return row
  }
  
  init(row: Row) throws {
    self.username = try row.get("username")
  }
}

// MARK: Fluent Preparation

extension User: Preparation {
  
  static func prepare(_ database: Database) throws {
    try database.create(self) { builder in
      builder.id()
      builder.string("username")
    }
  }
  
  static func revert(_ database: Database) throws {
    try database.delete(self)
  }
}

// MARK: JSON
extension User: JSONConvertible {
  convenience init(json: JSON) throws {
    self.init(username: try json.get("username"))
  }
  
  func makeJSON() throws -> JSON {
    var json = JSON()
    try json.set("id", assertExists())
    try json.set("username", username)
    return json
  }
}
