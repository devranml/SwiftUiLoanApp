# SwiftUiLoanApp

Merhaba,

Görüşmemizde konuştuğumuz noktaları ve verilen gereksinimleri dikkate alarak projede bazı mimari ve teknik iyileştirmeler yaptım.

UIKit ile hazırlanmış mevcut ekranları SwiftUI'a taşıdım. Bu süreçte SwiftUI tarafında gereğinden fazla görsel veya yapısal karmaşıklığa girmek yerine, mevcut uygulamanın davranışını mümkün olduğunca korumaya çalıştım. Bununla birlikte tekrar eden UI parçaları için FormField, ConfigurableButton, LoanCard ve LoanSummaryCard gibi yeniden kullanılabilir custom component'ler oluşturdum.

Navigasyon tarafında doğrudan ekran geçişleri yerine merkezi bir Coordinator yapısı kullandım. Coordinator'ı yalnızca mevcut Login → Home akışına özel düşünmek yerine, ekranların ileride root, push veya modal olarak gösterilebilmesine uygun olacak şekilde tasarladım. Mevcut akışta Login root olarak açılıyor, başarılı girişten sonra Home push ediliyor ve logout sonrasında navigation stack tekrar Login ekranına dönüyor. Uygulama ilk açıldığında mevcut session durumu da kontrol ediliyor.

Kredi işleme tarafında özellikle Strategy Pattern üzerinde durdum. Her kredi türünün faiz ve duruma bağlı iş kurallarını kendi strategy implementasyonuna ayırdım. Böylece personal, mortgage, auto ve business kredileri birbirinden bağımsız olarak işleniyor ve yeni bir kredi türü eklemek mevcut strategy'leri değiştirmeyi gerektirmiyor. Ortak vade ve durum güncelleme kurallarını da strategy'lerden ayırarak sorumlulukların daha net olmasını hedefledim.

Projenin genel yapısını Data, Domain ve Presentation katmanlarına ayırdım. View'ların yalnızca state'i gözlemleyip render etmesine, iş mantığının ViewModel ve Use Case katmanlarında kalmasına dikkat ettim. Ortak loading ve error state'leri için BaseViewModel, renk ve tipografi için merkezi provider'lar, form doğrulaması için de ayrı validation rule'ları kullandım.

Localization tarafında kullanıcıya gösterilen metinleri kod içine dağılmış string literal'lar olarak bırakmak yerine merkezi bir yapıda topladım. Böylece hem metinlerin yönetimi hem de ileride farklı dil desteğinin eklenmesi daha kolay hale geldi.

Görüşmemize istinaden, doğrudan gereksinimlerde açıkça belirtilmeyen bazı küçük iyileştirmeler de yaptım. Örneğin JSON verisi principal_amount, interest_rate ve due_in gibi snake_case key'lerle geliyor. Model tarafında aynı isimlendirmeyi sürdürmek yerine Swift naming convention'a uygun olarak principalAmount, interestRate ve dueIn kullandım; dönüşümü JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase üzerinden gerçekleştirdim.

Test tarafında her kredi strategy'sini bağımsız olarak test ettim. Bunun yanında validation kuralları, kredi işleme use case'i, ViewModel filtreleme ve state geçişleri ile repository davranışları için unit testler ekledim. Dış bağımlılıkları gerçek implementasyonlara bağlamak yerine protocol tabanlı mock ve spy nesneleri kullanarak testlerin izole kalmasına dikkat ettim.

Eski dosyaları EX öneki ile yeniden adlandırdım, o dosyaları gözardı edebilirsiniz.

Uygulamanın Github Linki : https://github.com/devranml/SwiftUiLoanApp

Saygılar.
