import GRDB

// The shared database queue.
var dbQueue: DatabaseQueue!

func setupDatabase() {
    
    // Connect to the database
    // See https://github.com/groue/GRDB.swift/#database-connections
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString
    let databasePath = documentsPath.stringByAppendingPathComponent("db.sqlite")
    dbQueue = try! DatabaseQueue(path: databasePath)
    
    
    // Use DatabaseMigrator to setup the database
    // See https://github.com/groue/GRDB.swift/#migrations
    
    var migrator = DatabaseMigrator()
    
    migrator.registerMigration("CreatePersonsTable") { db in
        // That "collation" helps us compare person names in a localized case insensitive fashion
        // See https://github.com/groue/GRDB.swift/#unicode
        let collation = DatabaseCollation.localizedCaseInsensitiveCompare
        
        try db.execute(
            "CREATE TABLE persons (" +
                "id INTEGER PRIMARY KEY, " +
                "name TEXT NOT NULL COLLATE \(collation.name), " +
                "score INTEGER NOT NULL " +
            ")")
    }
    
    migrator.registerMigration("InitialPersons") { db in
        try Person(name: "Arthur", score: 250).insert(db)
        try Person(name: "Barbara", score: 750).insert(db)
        try Person(name: "Craig", score: 500).insert(db)
    }
    
    try! migrator.migrate(dbQueue)
}