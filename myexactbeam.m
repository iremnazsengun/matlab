!git init
!git remote add origin https://github.com/iremnazsengun/matlab.git


% Katsayı matrisi ve bilinmeyenler vektörü tanımlanıyor
A = [-2.002565 1 0; 1 -2.002565 1; 0 1 -2.002565];
b = [3.46275 4.617 3.46275]';

% Doğrusal sistem çözülüyor
y = A \ b;

% Çözümü ekrana yazdır
disp('Çözüm y =');
disp(y);

% x eksenindeki noktalar belirleniyor
x = 0:30:120;

% y vektörüne uç noktalar ekleniyor
y = [0; y; 0];

% Grafiği çizdir
plot(x, y, 'd', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% Eksen etiketleri ve başlık ekleme
xlabel('x ekseni');
ylabel('y değeri');
title('Sistemin Çözüm Noktaları');

% Izgarayı aç
grid on;
