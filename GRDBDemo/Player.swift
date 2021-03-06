import GRDB

struct Player: RowConvertible, MutablePersistable, Codable {
    var id: Int64?
    var name: String
    var score: Int
    
    // MARK: - GRDB
    
    /// The table name
    static let databaseTableName = "players"
    
    /// Update player id after successful insertion
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
    
    // MARK: - Random
    
    private static let names = ["Arthur", "Anita", "Barbara", "Bernard", "Craig", "Chiara", "David", "Dean", "Éric", "Elena", "Fatima", "Frederik", "Gilbert", "Georgette", "Henriette", "Hassan", "Ignacio", "Irene", "Julie", "Jack", "Karl", "Kristel", "Louis", "Liz", "Masashi", "Mary", "Noam", "Nicole", "Ophelie", "Oleg", "Pascal", "Patricia", "Quentin", "Quinn", "Raoul", "Rachel", "Stephan", "Susie", "Tristan", "Tatiana", "Ursule", "Urbain", "Victor", "Violette", "Wilfried", "Wilhelmina", "Yvon", "Yann", "Zazie", "Zoé"]
    
    static func randomName() -> String {
        return names[Int(arc4random_uniform(UInt32(names.count)))]
    }
    
    static func randomScore() -> Int {
        return 10 * Int(arc4random_uniform(101))
    }
}
