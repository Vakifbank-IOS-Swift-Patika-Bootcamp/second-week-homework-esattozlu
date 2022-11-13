# Second-Week-Homework

## 1. CompanyManagementApp İhtiyaçlar

- Şirketimizin isim, çalışan, bütçe, kuruluş yılı olacak
- Şirketimize playground arayüzünden gelir ekleyip gider çıkışı sağlayabilmeliyim.
- Şirkete çalışan ekleyebilmeliyim.
- Çalışanlar için en az isim, yaş, medeni hal tutulmalı.
- En az 3 çalışan tipi olmalı. Jr. Mid. Sr. gibi
- Çalışanların maaşları yaş ve tip arasında bir formül belirleyerek hesaplanmalı. yaş * tip_katsayısı * 1000 gibi
- Şirketimin maaş ödemesini yapan bir metodu olmalı.
- Ödenen maaşlar bütçeden düşmeli
- Maaş ödemesi yapıldıktan sonra yazılım bana ekstra yapabileceğim komutlara izin vermeli.
- Protocol, closure, optional kullanımı zorunludur.
 
 ## Proje
 
 - CompanyManagementApp.playgorund, şirket ismi, kuruluş yılı, bütçe ve varsa çalışan parametreleriyle şirket oluşturduğumuz bir playground dosyasıdır. Kurduğumuz şirkete ister kuruluşta ister daha sonrasında çalışan eklenebilir veya çıkarılabilir, bütçeye gelir & gider eklenebilir ve bütçeden maaşlar ödenebilir.

- Şirket kuruluşunda çalışan eklemek optional'dır (default değeri nil). Eğer şirket, çalışanlar ile oluşturulacaksa Company class'ı initilize edilmeden önce Employee class'ından çalışanları barındıran bir array oluşturulmalıdır. Bu array Company class'ının initializer'ında parametre olarak kullanılacaktır.

- Eğer şirket çalışansız oluşturulacaksa Company class'ı initializer'ında employees parametresi kullanılmamalıdır.
- Çalışanlar sonradan hireEmployee fonksiyonu ile eklenebilir. Çalışan eklerken id'nin farklı olması gerekmektedir. Eğer aynı id'li çalışan eklenmeye çalışılırsa uyarı alınacaktır ve çalışan oluşturulamayacaktır.

- Çalışan çıkarılmak istenirse fireEmployee fonksiyonuna çalışan ismi(case insensitive) ve çalışan id'si verilmelidir.

- paySalary fonksiyonu ile çalışan maaşları ödenir. Completion'ında Employee array döner. Bu array'den maaşlar ödendikten sonra kime ne kadar maaş ödenmiş gibi bilgiler öğrenilebilir.
- addIncome fonksiyonu ile bütçeye gelir, addExpense ile bütçeye gider eklenebilir.

### SUCCESS MESSAGES:

- Şirket oluştuğunda: "\(name) Company is created in \(year) with \(employees?.count ?? 0) employee(s) and the budget of \(budget)₺"
- Çalışan çıkarıldığında: "\(employee.name) with id: \(employee.id) is fired."
- Çalışan eklendiğinde: "Employee \(name) is hired."
- Gelir eklendiğinde: "Income is added. Previos budget: \(previousBudget)₺, new budget: \(budget)₺"
- Gider eklendiğinde: "Expense is added. Previos budget: \(previousBudget)₺, new budget: \(budget)₺"
- Maaşlar ödendiğinde: "\(totalSalary)₺ employee salaries are paid. Remaining budget: \(budget)₺."

### FAILURE MESSAGES:

- Çalışan yokken çalışan çıkarmak istendiğinde: "There is no employee to fire."
- Çalışan çıkarılırken verilen parametrelere uyan çalışan yoksa: "There is no \(name) with id: \(id) employee to fire."
- Yeni çalışan eklenirken mevcut çalışana ait bir id denendiğinde: "There is already an employee with id: \(employeeId). Please try another id."
- Bütçede yeterli tutar yokken expense girilmek istendiğinde: "There is not enough money to pay expense. Please add income to budget case."
- Çalışan maaşları ödenmek istendiğinde yeterli bütçe yoksa: "There is not enough money to pay salaries. Please add income to budget case."
- Çalışan yokken çalışan maaşı ödenmek istendiğinde: "There is no employee to pay salary."

## 2. ZooManagementApp İhtiyaçlar

- Bahçemizde hayvanlarımız, bakıcılarımız olacak.
- Hayvanat bahçemizin hem bir günlük su limiti hem de bit bütçesi olacak.
- Hayvanat bahçesine gelir, gider eklemesi ve su limiti artırma yapılabilmelidir.
- Hayvanların su tüketimleri, sesleri olmalı
- Her hayvanın tek bakıcısı olmalıdır ancak bakıcılar birden fazla hayvana bakabilmelidir.
- Bulunan hayvanların su tüketimleri günlük limitten düşmelidir.
- Bakıcıların maaş ödemelerini yapılabilmeli. Hesap formulü kararı size bırakılmıştır.
- Sonradan bakıcı ve hayvan eklemesi yapılabilmelidir. 
- Aynı hayvandan 1 den fazla olabilmelidir.
- Protocol, closure, optional, computed property kullanımı zorunludur.

 ## Proje
 
- ZooManagementApp.playgorund, Hayvanat bahçesi yönetimi için oluşturulmuş bir playground dosyasıdır.

- Hayvanat bahçesi, isim, su limiti ve bütçe ile oluşturulabilir. Daha sonra getNewAnimal ve hireZooKeeper methodlarıyla yeni hayvan ve bakıcı eklenebilir.

- getNewAnimal methodu sadece yeni hayvan oluşturulurken kullanılır. Eğer mevcut hayvan sayısını arttırmak istiyorsak getNewAnimal methodu daha önce bu hayvanın oluşturulduğuna dair uyarı verecektir. Bu durumda addToExisting methodu ile ekleme yapılmalıdır.

- Yeni hayvan eklerken de, mevcuta ekleme yaparken de su limiti, hayvanların tüketimlerinden fazla olmalıdır. Eğer değilse su limitinin en az ne kadar arttırılması gerektiği uyarısı alınır. Bu durumda increaseWaterLimit ile istenen miktarda artış yapılabilir veya reviseWaterLimit ile toplam water limit değiştirilebilir.

- Bakıcı sayısı arttırılmak istenirse hireZooKeeper methodu kullanılabilir. Bakıcı eklerken id'nin mevcut bakıcı id'lerinden farklı olması gerekmektedir. Eğer aynı id'li çalışan eklenmeye çalışılırsa uyarı alınacaktır ve çalışan oluşturulamayacaktır.

- addIncome methoduyla bütçeye gelir, addExpense methoduyla gider oluşturulabilir. Eğer gider bütçeden yüksek ise expense girişi yapılamaz ve uyarı alınır.

- Çalışan maaşları baktıkları hayvan türü sayısına göre hayvan başına 0,05 prim katsayısı ile hesaplanır. Baz maaş 7000₺'dir.
- paySalary methodu ile çalışan maaşları ödenebilir. Completion'ında ZooKeeper array döner. Bu array'den maaşlar ödendikten sonra kime ne kadar maaş ödenmiş, kaç hayvandan sorumlu gibi bilgiler öğrenilebilir.
- Eğer maaş ödemesi için yeterli bütçe yoksa ödeme yapılamaz ve uyarı alınır.

- Kalan su limiti askRemainingWaterLimit methoduyla sorgulanabilir.

- SUCCESS MESSAGES:

- Hayvanat bahçesi oluştuğunda: "\(zooName) Zoo is created with \(waterLimit) water limit, \(budget)₺ budget."
- waterLimit değiştirildiğinde: "Water limit is changed to \(waterLimit)"
- waterLimit arttırıldığında: "Water limit is increased by \(amount) to \(waterLimit)"
- Gelir eklendiğinde: "Income is added. Previos budget: \(previousBudget)₺, new budget: \(budget)₺"
- Gider eklendiğinde: "Expense is added. Previos budget: \(previousBudget)₺, new budget: \(budget)₺"
- Maaşlar ödendiğinde: "\(totalSalary)₺ keeper salaries are paid. Remaining budget: \(budget)₺."
- Yeni hayvan eklendiğinde: "\(animal.animalType) type, \(animalBreed) breed animal is added."
- Bakıcı işe alındığında: "Keeper \(keeper.name) is hired."
- Kalan su limiti sorgulandığında: "Remaining water limit:", remainingLimit
- Mevcut hayvana ekleme yapıldığında: "\(previousCount) \(animal.animalBreed) increased to \(animals[index].count)."

- FAILURE MESSAGES:

- Hayvan array'i ile hayvanat bahçesi oluşturulurken eğer hayvanların su tüketimi limitin üzerindeyse: "Total consumption(\(totalConsumption)) of animals is higher than Water Limit. Please increase Water Limit at least \(totalConsumption - waterLimit)"
- Bütçede yeterli tutar yokken expense girilmek istendiğinde: "There is not enough money to pay expense. Please add income to budget case."
- Çalışan maaşları ödenmek istendiğinde yeterli bütçe yoksa: "There is not enough money to pay salaries. Please add income to budget case."
- Çalışan yokken çalışan maaşı ödenmek istendiğinde: "There is no keeper to pay salary."
- Yeni hayvan eklenirken su limiti yetmezse: "Remaining water limit of zoo is not enough to get \(count) \(animalBreed). Please increase the water limit at least \(animal.waterConsumption * Double(animal.count) - remainingLimit)."
- Yeni eklenmek istenen hayvan daha önce oluşturulmuşsa: "There is already an animal with type: \(animalType), breed: \(animalBreed). Please call addToExisting function."
- Bakıcı eklenirken aynı id'ye sahip bakıcı eklenirse: "There is already a keeper with id: \(keeper.keeperId). Please try another id."
- Hayvan eklenmemişken mevcut hayvana yeni ekleme yapılmak istendiğinde: "There is no animal in the zoo. Please use getNewAnimal method."
- Mevcut hayvana ekleme yapılmak istendiğinde su limiti yeterli değilse: "There is not enough water limit to add \(count) \(animalType) typed \(animalBreed). Please increase the water limit at least \(animal.waterConsumption * Double(count) - remainingLimit)"
- Mevcut hayvana ekleme yapılmak istendiğinde daha önce tanımlanmayan giriş yapıldığında: "Type: \(animalType), breed: \(animalBreed) animal is not previosly defined. Please use getNewAnimal method."
