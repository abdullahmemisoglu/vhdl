
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
5 adet LED (Her biri senkron çalışacak)

[![Watch the video](https://www.youtube.com/channel/UCM2VpQ59A-h3u8ruFEbbZ9g)](https://www.youtube.com/watch?v=30YYEKkP_8A&ab_channel=AbdullahMemi%C5%9Fo%C4%9Flu)
