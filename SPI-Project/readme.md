**Proje 2: SPI Protokolünün VHDL Dilinde İmplemente Edilmesi**

Bu proje kapsamında SPI (Serial Peripheral Interface) protokolü VHDL dilinde implemente edilecektir. Bu protokolün işleyip işlemediğini test etmek için osiloskop kullanılacaktır. FPGA’den gönderilen sinyali bir PMOD Connector portu üzerinden Osiloskop’a aktarmak amaçlanmaktadır.
	
**SPI (Serial Peripheral Interface) Protokolü:**

Bu protokolün en önemli özellikleri eş zamanlı çalışabilme (syncchronous), çift yönlü veri transferini destekleyebilme (full-duplex) ve ana-yardımcı birim arasında haberleşme sağlayabilme (master-slave based) özelliğidir. Veri aktarım işlemleri master (Ana kart) tarafından üretilen bir clock sinyali senkron gerçekleşmektedir.

SPI implementasyonunda master ve slave için girdi ve çıktılar belirlenmelidir. Bu protokol bir master tarafından birden çok alt komponente (slave) veri aktarımı sunabilmektedir. Bu proje kapsamında bir slave ve bir master arasında haberleşme gerçekleştirilecektir. Amaç bir SPI modülü oluşturmak, bu modüle giriş sinyali üreten ve bu sinyali master üzerinden osiloskopa ileten bir top modül oluşturmaktır. SPI master ve SPI Slave arasındaki bağıntı ve sinyal tanımları aşağıdaki gibidir. 

![p1](https://user-images.githubusercontent.com/57804784/132985955-175a7a65-130a-45fe-b985-0cc4179a1aae.png)

SPI protokolünde iki önemli kavram clock polarity ve clock phase’dir. Bu iki kavram çift yönlü aktarımın sistemini belirlemektedir. Kavramlar ve işlevleri tablosu aşağıdaki gibidir. 



