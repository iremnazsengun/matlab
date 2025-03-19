% Parametrelerin tanımlanması
a = 0; % Başlangıç noktası
b = 1; % Bitiş noktası
N = 20; % Düğüm sayısı (h = 1/N)
h = (b - a) / N; % Adım boyutu

% Düğüm noktalarının oluşturulması
t = linspace(a, b, N+1); % t0, t1, ..., tN düğüm noktaları
p = @(t) -2*t ./ (1 + t.^2); % p(t) fonksiyonu
q = @(t) 1; % q(t) fonksiyonu
r = @(t) 1 ./ (1 + t.^2) - log(1 + t.^2); % r(t) fonksiyonu

% Matrislerin oluşturulması
A = zeros(N+1, N+1); % Katsayı matrisi
b_vec = zeros(N+1, 1); % Sağ taraf vektörü

% İç düğüm noktaları için denklemler
for i = 2:N
    A(i, i-1) = 1/h^2 - p(t(i))/(2*h); % alt diyagonal
    A(i, i) = -2/h^2 + q(t(i)); % ana diyagonal
    A(i, i+1) = 1/h^2 + p(t(i))/(2*h); % üst diyagonal
    b_vec(i) = r(t(i)); % Sağ taraf
end

% Sınır koşulları
A(1, 1) = 1; % Y(0) = 0
b_vec(1) = 0; 
A(N+1, N+1) = 1; % Y(1) = log(2)
b_vec(N+1) = log(2);

% Lineer sistemin çözümü
y_h = A \ b_vec; % Yaklaşık çözüm

% Gerçek çözümün hesaplanması
Y_real = log(1 + t.^2); % Y(t) = log(1 + t^2)

% Grafiklerin çizdirilmesi
figure;
plot(t, Y_real, 'r-', 'LineWidth', 2); % Gerçek çözüm
hold on;
plot(t, y_h, 'bo-', 'LineWidth', 1.5, 'MarkerSize', 6); % Yaklaşık çözüm
grid on;

% Grafik detayları
title('BVP Çözümü ve Gerçek Çözüm Karşılaştırması');
xlabel('t');
ylabel('Y(t)');
legend('Gerçek Çözüm', 'BVP Yaklaşık Çözüm');
hold off;

