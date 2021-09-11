
**Proje Tanımı:**

Projenin amacı bir LED’i bir girdiye bağlı olarak değişen belirli doluluk boşluk oranlarına (duty cycle) göre sürmektir.

Proje Spesifikasyonları gereği sistem clock frekansı 25MHz, PWM frekansı 10 kHz seçilmiştir. Böylece
PeriodConstant = ClockFreq / PWM-freq = 2500

%0     => 2500 * 0/100 = 0\
%25   => 2500 * 25/100 = 625\
%50   => 2500 * 50/100 = 1250\
%75   => 2500 * 75/100 = 1875\
%100 => 2500 * 100/100 = 2500

2 adet buton (1 adet duty cycle arttırma, 1 adet duty cycle azaltma)
5 adet LED (Her biri senkron çalışacak)\
![Alt Text](https://drive.google.com/drive/u/1/folders/1KXq_9G7rf_T8NwCTYWrsTnJ1KKOm1xfg)
