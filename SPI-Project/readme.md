**Proje 2: SPI Protokolünün VHDL Dilinde İmplemente Edilmesi**

Bu proje kapsamında SPI (Serial Peripheral Interface) protokolü VHDL dilinde implemente edilecektir. Bu protokolün işleyip işlemediğini test etmek için osiloskop kullanılacaktır. FPGA’den gönderilen sinyali bir PMOD Connector portu üzerinden Osiloskop’a aktarmak amaçlanmaktadır.
	
**SPI (Serial Peripheral Interface) Protokolü:**

Bu protokolün en önemli özellikleri eş zamanlı çalışabilme (syncchronous), çift yönlü veri transferini destekleyebilme (full-duplex) ve ana-yardımcı birim arasında haberleşme sağlayabilme (master-slave based) özelliğidir. Veri aktarım işlemleri master (Ana kart) tarafından üretilen bir clock sinyali senkron gerçekleşmektedir.

SPI implementasyonunda master ve slave için girdi ve çıktılar belirlenmelidir. Bu protokol bir master tarafından birden çok alt komponente (slave) veri aktarımı sunabilmektedir. Bu proje kapsamında bir slave ve bir master arasında haberleşme gerçekleştirilecektir. Amaç bir SPI modülü oluşturmak, bu modüle giriş sinyali üreten ve bu sinyali master üzerinden osiloskopa ileten bir top modül oluşturmaktır. SPI master ve SPI Slave arasındaki bağıntı ve sinyal tanımları aşağıdaki gibidir. 

![p1](https://user-images.githubusercontent.com/57804784/132985955-175a7a65-130a-45fe-b985-0cc4179a1aae.png)

SPI protokolünde iki önemli kavram clock polarity ve clock phase’dir. Bu iki kavram çift yönlü aktarımın sistemini belirlemektedir. Kavramlar ve işlevleri tablosu aşağıdaki gibidir. 

![p2](https://user-images.githubusercontent.com/57804784/132985994-8b69a2e2-df16-427c-b964-20f707dcbd51.PNG)

Yapılacak tasarımda aşağıdakilere dikkat edilmelidir.

•CS biti ‘0’ değeri aldığında girdi olarak verilen sinyalin slave’e iletimi başlayacak ve iletim boyunca CS biti ‘0’ değeri alacak. İletim tamamlandığında CS biti ‘1’ değeri alır.  

•Tasarımda SPI için clock frekansı 1 MHz, sistem clock frekansı ise 25MHz olarak belirtilmiştir. Buna göre 1 SPI clock periyodunda 25 sistem clock periyodu gözlemlenmelidir. 

•1 byte veri aktarımı için 8 SPI clock süresi geçmelidir. Bu süre 1 frame aktarımı süresi demektir. 1 frame aktarımı 8 SPI clock süresi bu da 200 sistem clock süresi olmalıdır. CS biti ‘0’ değer aldıktan sonra bu süre kadar ‘0’ değeri almaya devam etmelidir.  

•SPI clock sadece CS biti ‘0’ iken clock davranışı sergilemelidir. CS biti ‘1’ ise clock değeri de ‘0’ olmalıdır.  

Tasarımdan beklenen bir çıktı örneği aşağıdaki gibi olmalıdır. 

![p3](https://user-images.githubusercontent.com/57804784/132986138-86abcef5-b555-4aa4-94c0-fc3838338c83.png)


**SPI Protokolü VHDL İmplementasyonu:**

Modüle çalışma clock frekansı bilgisini vermek için bir adet clock için bir değişken(clk), protokolün veri aktarımı-bekleme aşamalarından hangisinde olacağını belirleyen bir değişken(en) ve aktarılacak veri, bu projede 1 byte olarak belirlenmiştir, için bir değişken(mosi_data) olmak üzere üç girdi bulunmaktadır. Çıktılar ise osiloskopta görülmesi beklenen Chip Select (cs), SPI Clock(sclk) ve aktarımı gerçekleşen veri(mosi) olmak üzere 3 tanedir. İlgili modülün girdi ve çıktılarını içeren diyagram aşağıdaki gibidir.

![p4](https://user-images.githubusercontent.com/57804784/132986211-6128f06c-4f9f-4da0-8aa0-142d67a1650d.png)

 **İmplementasyon Modülü Testi:**

Bir üst modül oluşturularak belirli düzen ile sinyal gönderilip test aşaması gerçekleştirilir. Testin diyagramı aşağıdaki gibidir. 

![p5](https://user-images.githubusercontent.com/57804784/132986313-6a39b4e4-a376-4b6c-a0b6-59546150ea19.png)

**SİSTEM ÇIKTILARI:**\
**Bu projede SPI_MODULE.vhd ve SPI_Project.vhd kodları kullanarak ilgili sonuçlar elde edilmiştir.** 
![p7](https://user-images.githubusercontent.com/57804784/132986372-2acf83ad-4c33-44d8-923b-a819a2fa0189.jpg)
![p6](https://user-images.githubusercontent.com/57804784/132986374-6dd5c9e7-c706-413a-83dd-a8dbc143c02b.png)
\
**Bu projede SPI_MODULE.vhd ve TB_SPI_Project.vhd kodları kullanarak ilgili sonuçlar elde edilmiştir.** 
![SPI-TB](https://user-images.githubusercontent.com/57804784/132987395-6ee3bafb-98e7-4cf2-861a-c552e47500b2.PNG)
