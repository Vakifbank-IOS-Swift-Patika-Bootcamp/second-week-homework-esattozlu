import UIKit

protocol ZooCreator { // Protocol ✅
    var waterLimit: Double { get set }
    var budget: Double { get set }
    var animals: [Animal]? { get set }
    var keepers: [ZooKeeper]? { get set }
    var remainingLimit: Double { get }
    
    func addIncome(amount: Double)
    func addExpense(amount: Double)
    func getNewAnimal(animalType: AnimalTypes, animalBreed: String, waterConsumption: Double, sound: String, keeper: ZooKeeper, count: Int)
    func hireZooKeeper(name: String, responsibleFor animals: [Animal], keeperId: Int, age: Int?)
    func paySalary(completion: ([ZooKeeper]) -> ())
}


enum AnimalTypes {
    case Mammals
    case Birds
    case Reptiles
    case Amphibians
    case Invertebrates
    case Fish
}


class ZooKeeper {
    let name: String
    var keeperId: Int
    var animals: [Animal]?
    var salary: Double {    // computed property ✅
        if let animals = animals {
            return (1 + Double(animals.count) / 20) * 7000
        } else {
            return 7000
        }
    }
    
    init(name: String, keeperId: Int){
        self.name       = name
        self.keeperId   = keeperId
    }
}


class Animal {
    let animalType: AnimalTypes
    let animalBreed: String
    let waterConsumption: Double
    let sound: String
    let keeper: ZooKeeper
    var count: Int
    var totalWaterConsumption: Double {
        Double(count) * waterConsumption
    }
    
    init(animalType: AnimalTypes, animalBreed: String, waterConsumption: Double, sound: String, keeper: ZooKeeper, count: Int) {
        self.animalType         = animalType
        self.animalBreed        = animalBreed
        self.waterConsumption   = waterConsumption
        self.sound              = sound
        self.keeper             = keeper
        self.count              = count
        
        giveResponsibility()
    }
    
    func giveResponsibility() {
        if var animals = keeper.animals {
            animals.append(self)
            keeper.animals = animals
        } else {
            var animals = [Animal]()
            animals.append(self)
            keeper.animals = animals
        }
    }
}


class Zoo {
    private var zooName: String
    private var waterLimit: Double
    private var budget: Double
    private var animals: [Animal]?
    private var keepers: [ZooKeeper]?
    private var remainingLimit: Double {    // computed property ✅
        guard let animals = animals else { return 0 }
        var totalConsumption: Double = 0
        animals.forEach{ totalConsumption += $0.waterConsumption * Double($0.count)}
        return waterLimit - totalConsumption
    }
    
    
    init?(zooName: String, waterLimit: Double, budget: Double, animals: [Animal]?, keepers: [ZooKeeper]?) {
        var totalConsumption: Double = 0
        animals?.forEach{ totalConsumption += $0.waterConsumption * Double($0.count) }
        
        guard waterLimit >= totalConsumption else {
            print("Total consumption(\(totalConsumption)) of animals is higher than Water Limit. Please increase Water Limit")
            return nil
        }
        
        self.waterLimit     = waterLimit
        self.budget         = budget
        self.animals        = animals
        self.keepers        = keepers
        self.zooName        = zooName
        print("\(zooName) Zoo is created with \(animals?.count ?? 0) types of animal(s) and \(keepers?.count ?? 0) keeper(s).")
    }
    
    
    init(zooName: String, waterLimit: Double, budget: Double) {
        self.waterLimit     = waterLimit
        self.budget         = budget
        self.zooName        = zooName
        print("\(zooName) Zoo is created with \(animals?.count ?? 0) types of animal(s) and \(keepers?.count ?? 0) keeper(s).")
    }
    
    // gelir eklemek için kullanılır
    func addIncome(amount: Double) {
        var previousBudget  = budget
        budget             += amount
        print("Income is added. Previos budget: \(previousBudget)₺, new budget: \(budget)₺")
    }
    
    // gider eklemek için kullanılır
    func addExpense(amount: Double) {
        // eğer budget'da yeterli para yoksa uyarı verir ve gider oluşmaz.
        if budget >= amount {
            var previousBudget  = budget
            budget             -= amount
            print("Expense is added. Previos budget: \(previousBudget)₺, new budget: \(budget)₺")
        } else {
            print("There is not enough money to pay expense. Please add income to budget case.")
        }
    }
    
    // Su limitini revise eder
    func reviseWaterLimit(limit: Double) {
        waterLimit = limit
        print("Water limit is changed to \(waterLimit)")
    }
    
    // Su limitini belirtilen miktarda arttırır eder
    func increaseWaterLimit(amount: Double) {
        waterLimit += amount
        print("Water limit is increased to \(waterLimit)")
    }
    
    // maaşları öder
    func paySalary(completion: ([ZooKeeper]) -> () = {_ in }) { // Closure ✅
        if let keepers = keepers, !keepers.isEmpty{
            var totalSalary: Double = 0
            keepers.forEach{ totalSalary += $0.salary }
            
            if budget >= totalSalary {
                budget -= totalSalary
                print("\(totalSalary)₺ keeper salaries are paid. Remaining budget: \(budget)₺.")
            } else {
                // eğer budget'da maaşlar için yeterli para yoksa uyarı verir ve gider oluşmaz.
                print("There is not enough money to pay salaries. Please add income to budget case.")
            }
            // maaş ödemesi sonrası hangi bakıcı hangi hayvana bakıyor ve ne kadar maaş alıyor gibi bilgileri öğrenebilmek için completion
            completion(keepers)
        } else {
            print("There is no keeper to pay salary.")
        }
    }
    
    // yeni hayvan alır
    func getNewAnimal(animalType: AnimalTypes, animalBreed: String, waterConsumption: Double, sound: String, keeper: ZooKeeper, count: Int) {
        let animal = Animal(animalType: animalType, animalBreed: animalBreed, waterConsumption: waterConsumption, sound: sound, keeper: keeper, count: count)
        guard animal.waterConsumption * Double(animal.count) <= remainingLimit else {
            print("Remaining water limit of zoo is not enough to get this animal. Please increase the water limit at least \(animal.waterConsumption * Double(animal.count) - remainingLimit).")
            return
        }
        var breedCheck = true
        
        if var animals = animals {
            // Hayvan eklenirken, eklemek istenen türe ve tipe sahip daha önce bir hayvan olup olmadığı kontrolü.
            animals.forEach{
                if $0.animalBreed.lowercased() == animalBreed.lowercased() && $0.animalType == animalType{
                    print("There is already an animal with breed: \(animalBreed). Please call addToExisting function.")
                    breedCheck = false
                    return
                }
            }
            // eğer eklenen aynı breed'e sahip hayvan varsa fonksiyonu devam ettirmemek için guard
            guard breedCheck else { return }
            
            animals.append(animal)
            self.animals = animals
        } else {
            var animals = [Animal]()
            animals.append(animal)
            self.animals = animals
        }
        
        print("\(animal.animalType) type, \(animalBreed) breed animal is added.")
    }
    
    // yeni bakıcı alır
    func hireZooKeeper(name: String, keeperId: Int) {
        var keeper = ZooKeeper(name: name, keeperId: keeperId)
        var idCheck = true
        
        if var keepers = keepers {
            // Keeper eklenirken, eklemek istenen id'ye sahip daha önce bir çalışan olup olmadığı kontrolü.
            keepers.forEach{
                if $0.keeperId == keeperId {
                    print("There is already a keeper with id: \(keeperId). Please try another id.")
                    idCheck = false
                    return
                }
            }
            // eğer eklenen id'li keeper varsa fonksiyonu devam ettirmemek için guard
            guard idCheck else { return }
            
            keepers.append(keeper)
            self.keepers = keepers
        } else {
            var keepers = [ZooKeeper]()
            keepers.append(keeper)
            self.keepers = keepers
        }
        
        print("Keeper \(name) is hired.")
    }
    
    
    func askRemainingWaterLimit() {
        print("Remaining water limit: ", remainingLimit)
    }
    
    
    
    func addToExisting(animalType: AnimalTypes, animalBreed: String, count: Int) {
        guard let animals = animals else { return }
        for (index, animal) in animals.enumerated() {
            if animalType == animal.animalType && animalBreed.lowercased() == animal.animalBreed.lowercased() {
                guard animal.waterConsumption * Double(count) <= remainingLimit else {
                    print("There is not enough limit to add new animals. Please increase the water limit at least \(animal.waterConsumption * Double(count) - remainingLimit)")
                    return
                }
                let previousCount = animals[index].count
                animals[index].count += count
                print("\(previousCount) \(animal.animalBreed) increased to \(animals[index].count).")
                break
            }
        }
    }
}

let keeper1 = ZooKeeper(name: "Ali", keeperId: 1)
let keeper2 = ZooKeeper(name: "Osman", keeperId: 2)
let animal1 = Animal(animalType: .Mammals, animalBreed: "Inek", waterConsumption: 2000, sound: "Mö", keeper: keeper1, count: 2)
let animal2 = Animal(animalType: .Birds, animalBreed: "Güvercin", waterConsumption: 20, sound: "Cik", keeper: keeper2, count: 5)
let zoo = Zoo(zooName: "Ali Baba Çiftliği", waterLimit: 8100, budget: 2000, animals: [animal1, animal2], keepers: [keeper1, keeper2])
zoo?.getNewAnimal(animalType: .Birds, animalBreed: "inek", waterConsumption: 2000, sound: "mö", keeper: keeper1, count: 2)
zoo?.increaseWaterLimit(amount: 4000)
zoo?.addToExisting(animalType: .Mammals, animalBreed: "inek", count: 2)
zoo?.addExpense(amount: 1000)
print(keeper1.animals?.count)
print(keeper1.salary)
print(keeper2.salary)

