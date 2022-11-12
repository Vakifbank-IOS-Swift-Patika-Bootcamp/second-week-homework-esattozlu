// ZooManagementApp.playgorund, Hayvanat bahçesi yönetimi için oluşturulmuş bir playground dosyasıdır.
// Hayvanat bahçesi oluşturmadan önce içerideki hayvanlar ve çalışanlar önceden belliyse hayvanat bahçesi ismi, su limiti, bütçe, hayvanlar ve çalışanları kullanarak hayvanat bahçesi oluşturulabilir.
// Eğer belli değilse hayvanat bahçesi ismi, su limiti ve bütçe ile hayvanat bahçesi oluşturulabilir. Daha sonra getNewAnimal ve hireZooKeeper methodlarıyla yeni hayvan ve bakıcı eklenebilir.

// getNewAnimal methodu sadece yeni hayvan oluşturulurken kullanılır. Eğer mevcut hayvan sayısını arttırmak istiyorsak getNewAnimal methodu daha önce bu hayvanın oluşturulduğuna dair uyarı verecektir. Bu durumda addToExisting methodu ile ekleme yapılmalıdır.

// Yeni hayvan eklerken de, mevcuta ekleme yaparken de su limiti, hayvanların tüketimlerinden fazla olmalıdır. Eğer değilse uyarı alarak su limitinin en az ne kadar arttırılması gerektiği uyarısı alınır. Bu durumda eğer hayvanat bahçesi oluşturulmuş ise increaseWaterLimit ile istenen miktarda artış yapılabilir veya reviseWaterLimit ile toplam water limit değiştirilebilir. Eğer hayvanat bahçesi henüz oluşturulmadıysa init içerisine verilen water limit miktarı arttırılmalı.

// Bakıcı sayısı arttırılmak istenirse hireZooKeeper methodu kullanılabilir. Bakıcı eklerken id'nin mevcut bakıcı id'lerinden farklı olması gerekmektedir. Eğer aynı id'li çalışan eklenmeye çalışılırsa uyarı alınacaktır ve çalışan oluşturulamayacaktır.

// addIncome methoduyla bütçeye gelir, addExpense methoduyla gider oluşturulabilir. Eğer gider bütçeden yüksek ise expense girişi yapılamaz ve uyarı alınır.

// Çalışan maaşları baktıkları hayvan sayısına göre hayvan başına 0,05 prim hesabı ile yapılır. Baz maaş 7000₺'dir.
// paySalary methodu ile çalışan maaşları ödenebilir. Completion'ında ZooKeeper array döner. Bu array'den maaşlar ödendikten sonra kime ne kadar maaş ödenmiş, kaç hayvandan sorumlu gibi bilgiler öğrenilebilir.
// Eğer maaş ödemesi için yeterli bütçe yoksa ödeme yapılamaz ve uyarı alınır.
// Kalan su limiti askRemainingWaterLimit methoduyla sorgulanabilir.

// SUCCESS MESSAGES:
// Hayvanat bahçesi oluştuğunda: "\(zooName) Zoo is created with \(waterLimit) water limit, \(budget)₺ budget, \(animals?.count ?? 0) types of animal(s) and \(keepers?.count ?? 0) keeper(s)."
// Çalışan çıkarıldığında: "\(employee.name) with id: \(employee.id) is fired."
// waterLimit değiştirildiğinde: "Water limit is changed to \(waterLimit)"
// waterLimit arttırıldığında: "Water limit is increased by \(amount) to \(waterLimit)"
// Gelir eklendiğinde: "Income is added. Previos budget: \(previousBudget)₺, new budget: \(budget)₺"
// Gider eklendiğinde: "Expense is added. Previos budget: \(previousBudget)₺, new budget: \(budget)₺"
// Maaşlar ödendiğinde: "\(totalSalary)₺ keeper salaries are paid. Remaining budget: \(budget)₺."
// Yeni hayvan eklendiğinde: "\(animal.animalType) type, \(animalBreed) breed animal is added."
// Bakıcı işe alındığında: "Keeper \(keeper.name) is hired."
// Kalan su limiti sorgulandığında: "Remaining water limit:", remainingLimit
// Mevcut hayvana ekleme yapıldığında: "\(previousCount) \(animal.animalBreed) increased to \(animals[index].count)."

// FAILURE MESSAGES:
// Hayvan array'i ile hayvanat bahçesi oluşturulurken eğer hayvanların su tüketimi limitin üzerindeyse: "Total consumption(\(totalConsumption)) of animals is higher than Water Limit. Please increase Water Limit at least \(totalConsumption - waterLimit)"
// Çalışan çıkarılırken verilen parametrelere uyan çalışan yoksa: "There is no \(name) with id: \(id) employee to fire."
// Yeni çalışan eklenirken mevcut çalışana ait bir id denendiğinde: "There is already an employee with id: \(employeeId). Please try another id."
// Bütçede yeterli tutar yokken expense girilmek istendiğinde: "There is not enough money to pay expense. Please add income to budget case."
// Çalışan maaşları ödenmek istendiğinde yeterli bütçe yoksa: "There is not enough money to pay salaries. Please add income to budget case."
// Çalışan yokken çalışan maaşı ödenmek istendiğinde: "There is no keeper to pay salary."
// Yeni hayvan eklenirken su limiti yetmezse: "Remaining water limit of zoo is not enough to get \(count) \(animalBreed). Please increase the water limit at least \(animal.waterConsumption * Double(animal.count) - remainingLimit)."
// Yeni eklenmek istenen hayvan daha önce oluşturulmuşsa: "There is already an animal with type: \(animalType), breed: \(animalBreed). Please call addToExisting function."
// Bakıcı eklenirken aynı id'ye sahip bakıcı eklenirse: "There is already a keeper with id: \(keeper.keeperId). Please try another id."
// Hayvan eklenmemişken mevcut hayvana yeni ekleme yapılmak istendiğinde: "There is no animal in the zoo. Please use getNewAnimal method."
// Mevcut hayvana ekleme yapılmak istendiğinde su limiti yeterli değilse: "There is not enough water limit to add \(count) \(animalType) typed \(animalBreed). Please increase the water limit at least \(animal.waterConsumption * Double(count) - remainingLimit)"
// Mevcut hayvana ekleme yapılmak istendiğinde daha önce tanımlanmayan giriş yapıldığında: "Type: \(animalType), breed: \(animalBreed) animal is not previosly defined. Please use getNewAnimal method."

import UIKit

protocol ZooCreator { // Protocol ✅
    func addIncome(amount: Double)
    func addExpense(amount: Double)
    func getNewAnimal(animalType: AnimalTypes, animalBreed: String, waterConsumption: Double, sound: String, keeper: ZooKeeper, count: Int)
    func hireZooKeeper(keeper: ZooKeeper)
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
    // sorumlu olunan hayvan başına 0,05 kat sayısı ile maaş hesabı yapar(baz maaş: 7000₺)
    var salary: Double {    // computed property ✅
        if let animals = animals {
            return (1 + Double(animals.count) * 0.05) * 7000
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
    
    // Hayvan oluştuktan sonra belirtilen keeper a yetki verilir
    private func giveResponsibility() {
        if var animals = keeper.animals {
            animals.forEach{
                if $0.animalBreed.lowercased() == animalBreed.lowercased() && $0.animalType == animalType{
                    return
                } else {
                    animals.append(self)
                }
                keeper.animals = animals
            }
        } else {
            var animals = [Animal]()
            animals.append(self)
            keeper.animals = animals
        }
    }
}


class Zoo: ZooCreator {
    // Propertylerime dışarıdan müdahale olması istenmediği için private tanımlandı.
    private var zooName: String
    private var waterLimit: Double
    private var budget: Double
    var animals: [Animal]?
    private var keepers: [ZooKeeper]?
    private var remainingLimit: Double {    // computed property ✅
        guard let animals = animals else { return waterLimit }
        var totalConsumption: Double = 0
        animals.forEach{ totalConsumption += $0.waterConsumption * Double($0.count)}
        return waterLimit - totalConsumption
    }
    
    // Hayvanat bahçesini oluştururken başta hayvan ve bakıcıları vermeden, isim, su limiti ve bütçe ile init
    init(zooName: String, waterLimit: Double, budget: Double) {
        self.waterLimit     = waterLimit
        self.budget         = budget
        self.zooName        = zooName
        print("\(zooName) Zoo is created with \(waterLimit) water limit, \(budget)₺ budget, \(animals?.count ?? 0) types of animal(s) and \(keepers?.count ?? 0) keeper(s).")
    }
    
    // Bütçe, su limiti, isim, hayvanlar ve bakıcıların belli olduğu durumda kullanılacak init
    init?(zooName: String, waterLimit: Double, budget: Double, animals: [Animal]?, keepers: [ZooKeeper]?) {
        var totalConsumption: Double = 0
        animals?.forEach{ totalConsumption += $0.waterConsumption * Double($0.count) }
        
        // Hayvanların toplam su tüketimi water limiti aşıp aşmadığı kontrolü
        guard waterLimit >= totalConsumption else {
            print("Total consumption(\(totalConsumption)) of animals is higher than Water Limit. Please increase Water Limit at least \(totalConsumption - waterLimit)")
            return nil
        }
        
        self.waterLimit     = waterLimit
        self.budget         = budget
        self.animals        = animals
        self.keepers        = keepers
        self.zooName        = zooName
        print("\(zooName) Zoo is created with \(waterLimit) water limit, \(budget)₺ budget, \(animals?.count ?? 0) types of animal(s) and \(keepers?.count ?? 0) keeper(s).")
    }
    
    // Gelir eklemek için kullanılır
    func addIncome(amount: Double) {
        var previousBudget  = budget
        budget             += amount
        print("Income is added. Previos budget: \(previousBudget)₺, new budget: \(budget)₺")
    }
    
    // Gider eklemek için kullanılır
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
    
    // Su limitini belirtilen miktarda arttırır
    func increaseWaterLimit(amount: Double) {
        waterLimit += amount
        print("Water limit is increased by \(amount) to \(waterLimit)")
    }
    
    // Maaşları öder
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
            print("Remaining water limit of zoo is not enough to get \(count) \(animalBreed). Please increase the water limit at least \(animal.waterConsumption * Double(animal.count) - remainingLimit).")
            return
        }
        
        var breedCheck = true
        
        if var animals = animals {
            // Hayvan eklenirken, eklemek istenen türe ve tipe sahip daha önce bir hayvan olup olmadığı kontrolü.
            animals.forEach{
                if $0.animalBreed.lowercased() == animalBreed.lowercased() && $0.animalType == animalType{
                    print("There is already an animal with type: \(animalType), breed: \(animalBreed). Please call addToExisting function.")
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
    
    // yeni bakıcı işe alır
    func hireZooKeeper(keeper: ZooKeeper) {
        var idCheck = true
        
        if var keepers = keepers {
            // Keeper eklenirken, eklemek istenen id'ye sahip daha önce bir keeper olup olmadığı kontrolü.
            keepers.forEach{
                if $0.keeperId == keeper.keeperId {
                    print("There is already a keeper with id: \(keeper.keeperId). Please try another id.")
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
        
        print("Keeper \(keeper.name) is hired.")
    }
    
    // Kalan su limiti yazdırılır
    func askRemainingWaterLimit() {
        print("Remaining water limit:", remainingLimit)
    }
    
    
    //mevcut hayvan sayısı arttırılmak istendiğinde kullanılır
    func addToExisting(animalType: AnimalTypes, animalBreed: String, count: Int) {
        guard let animals = animals else {
            print("There is no animal in the zoo. Please use getNewAnimal method.")
            return
        }
        
        var animalFound = false
        
        for (index, animal) in animals.enumerated() {
            // Böyle bir hayvan olup olmadığı incelenir
            if animalType == animal.animalType && animalBreed.lowercased() == animal.animalBreed.lowercased() {
                
                guard animal.waterConsumption * Double(count) <= remainingLimit else {
                    print("There is not enough water limit to add \(count) \(animalType) typed \(animalBreed). Please increase the water limit at least \(animal.waterConsumption * Double(count) - remainingLimit)")
                    return
                }
                
                let previousCount = animals[index].count
                animals[index].count += count
                print("\(previousCount) \(animal.animalBreed) increased to \(animals[index].count).")
                animalFound = true
                break
            }
        }
        if !animalFound {
            print("Type: \(animalType), breed: \(animalBreed) animal is not previosly defined. Please use getNewAnimal method.")
            animalFound = false
        }
    }
}

// Hayvansız ve bakıcısız hayvanat bahçesi oluşturma
let zoo1 = Zoo(zooName: "Ali Babanın Çiftliği", waterLimit: 25_000, budget: 1_000_000)
zoo1.addExpense(amount: 400_000)        // Masraf girişi
zoo1.addIncome(amount: 100_000)         // Gelir girişi
zoo1.increaseWaterLimit(amount: 15_000) // Water limit'i 15_000 arttırır
zoo1.reviseWaterLimit(limit: 50_000)    // Water limiti 50_000'e günceller
let keeper1 = ZooKeeper(name: "Ali", keeperId: 1)
let keeper2 = ZooKeeper(name: "Osman", keeperId: 2)
let keeper3 = ZooKeeper(name: "Ahmet", keeperId: 2)
zoo1.hireZooKeeper(keeper: keeper1)
zoo1.hireZooKeeper(keeper: keeper2)
zoo1.hireZooKeeper(keeper: keeper3)     // Aynı id'ye sahip keeper'ın eklenmesine izin vermez.
zoo1.getNewAnimal(animalType: .Birds, animalBreed: "Deve Kuşu", waterConsumption: 4000, sound: "Guk", keeper: keeper1, count: 10)
zoo1.getNewAnimal(animalType: .Mammals, animalBreed: "Deve", waterConsumption: 8000, sound: "Ooo", keeper: keeper2, count: 3)
zoo1.increaseWaterLimit(amount: 14_000)
zoo1.getNewAnimal(animalType: .Mammals, animalBreed: "Deve", waterConsumption: 8000, sound: "Ooo", keeper: keeper2, count: 3)
zoo1.getNewAnimal(animalType: .Birds, animalBreed: "Deve Kuşu", waterConsumption: 400, sound: "Cak", keeper: keeper2, count: 1) // Aynı hayvanın yeniden eklenmesine izin vermiyor. Bunun yerine addToExisting'i çağırmamız gerektiğini yazıdırıyor.
zoo1.addToExisting(animalType: .Birds, animalBreed: "Muhabbet kuşu", count: 20) // Mevcut hayvan grubuna olmayan hayvan verdiğimiz için uyarı verir
zoo1.addToExisting(animalType: .Birds, animalBreed: "Deve Kuşu", count: 20)
zoo1.increaseWaterLimit(amount: 70000)
zoo1.askRemainingWaterLimit()           // Hayvanlar sonrasında geriye kalan su miktarını sorar
zoo1.paySalary { zookeepers in // maaş ödemesi sonrası hangi bakıcı hangi hayvana bakıyor ve ne kadar maaş alıyor gibi bilgileri öğrenebilmek için completion
    zookeepers.forEach{ print("\($0.name) keeper is responsible for \($0.animals?.count ?? 0) animals and get \($0.salary)₺ salary.")}
}

print("\n")

//Hayvanlar ve bakıcılar önceden belli olduğu durumda hayvanat bahçesi oluşturma
let keeper4 = ZooKeeper(name: "Ali", keeperId: 1)
let animal1 = Animal(animalType: .Birds, animalBreed: "Deve Kuşu", waterConsumption: 10_000, sound: "Guk", keeper: keeper4, count: 2)
let animal2 = Animal(animalType: .Mammals, animalBreed: "Deve", waterConsumption: 20_000, sound: "Ooo", keeper: keeper4, count: 2)
let zoo2 = Zoo(zooName: "Atatürk Orman Çiftliği", waterLimit: 60_000, budget: 1_000_000, animals: [animal1, animal2], keepers: [keeper4])
let keeper5 = ZooKeeper(name: "Osman", keeperId: 1)
zoo2?.hireZooKeeper(keeper: keeper5) // Keeper4 ile aynı id verdiğim için uyarı bastırır
let keeper6 = ZooKeeper(name: "Osman", keeperId: 2)
zoo2?.hireZooKeeper(keeper: keeper6)
zoo2?.getNewAnimal(animalType: .Mammals, animalBreed: "Ayı", waterConsumption: 30_000, sound: "Aaaa", keeper: keeper6, count: 2) // Water limit yetersiz uyarısı verir
zoo2?.increaseWaterLimit(amount: 60000) // 2 adet ayı alabilmek için water limiti 60_000 arttırır
zoo2?.getNewAnimal(animalType: .Mammals, animalBreed: "Ayı", waterConsumption: 30_000, sound: "Aaaa", keeper: keeper6, count: 2)
zoo2?.addIncome(amount: 200_000)
zoo2?.addExpense(amount: 300_000)
let keeper7 = ZooKeeper(name: "Mehmet", keeperId: 3)
zoo2?.paySalary { zookeepers in // maaş ödemesi sonrası hangi bakıcı hangi hayvana bakıyor ve ne kadar maaş alıyor gibi bilgileri öğrenebilmek için completion
    zookeepers.forEach{ print("\($0.name) keeper is responsible for \($0.animals?.count ?? 0) animals and get \($0.salary)₺ salary.")}
}
