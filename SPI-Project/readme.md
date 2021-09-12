**Proje 2: SPI Protokolünün VHDL Dilinde İmplemente Edilmesi**

Bu proje kapsamında SPI (Serial Peripheral Interface) protokolü VHDL dilinde implemente edilecektir. Bu protokolün işleyip işlemediğini test etmek için osiloskop kullanılacaktır. FPGA’den gönderilen sinyali bir PMOD Connector portu üzerinden Osiloskop’a aktarmak amaçlanmaktadır.
	
**SPI (Serial Peripheral Interface) Protokolü:**

Bu protokolün en önemli özellikleri eş zamanlı çalışabilme (syncchronous), çift yönlü veri transferini destekleyebilme (full-duplex) ve ana-yardımcı birim arasında haberleşme sağlayabilme (master-slave based) özelliğidir. Veri aktarım işlemleri master (Ana kart) tarafından üretilen bir clock sinyali senkron gerçekleşmektedir.

SPI implementasyonunda master ve slave için girdi ve çıktılar belirlenmelidir. Bu protokol bir master tarafından birden çok alt komponente (slave) veri aktarımı sunabilmektedir. Bu proje kapsamında bir slave ve bir master arasında haberleşme gerçekleştirilecektir. Amaç bir SPI modülü oluşturmak, bu modüle giriş sinyali üreten ve bu sinyali master üzerinden osiloskopa ileten bir top modül oluşturmaktır. SPI master ve SPI Slave arasındaki bağıntı ve sinyal tanımları aşağıdaki gibidir. 



