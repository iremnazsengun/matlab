function compare_numerical_exact()
    % Adım boyutları
    h_values = [0.8, 0.4, 0.2, 0.1];
    
    for h_idx = 1:length(h_values)
        h = h_values(h_idx);
        
        % Ağ noktaları
        t = 0:h:pi/2;
        N = length(t);
        
        % Matris ve sağ taraf vektörü
        A = zeros(N, N);
        b = zeros(N, 1);
        
        % Sınır koşulları
        A(1, 1) = 1;
        b(1) = 0;
        A(N, N) = 1;
        b(N) = 1;
        
        % İç noktalar için denklemler
        for i = 2:N-1
            A(i, i-1) = 1/h^2 + 1/(2*h);
            A(i, i) = -2/h^2 - 1;
            A(i, i+1) = 1/h^2 - 1/(2*h) - 1;
            b(i) = -cos(t(i))/2 - cos(t(i+1))/2 - 3*sin(t(i))/2 - 3*sin(t(i+1))/2;
        end
        
        % Lineer sistemi çöz
        Y = A\b;
        
        % Analitik çözüm
        Y_exact = sin(t);
        
        % Grafik çizme
        figure;
        plot(t, Y, 'o-', 'LineWidth', 1.5, 'DisplayName', 'Sayısal Çözüm');
        hold on;
        plot(t, Y_exact, '--', 'LineWidth', 1.5, 'DisplayName', 'Gerçek Çözüm');
        hold off;
        
        title(sprintf('h = %.2f için Sayısal ve Gerçek Çözüm', h));
        xlabel('t');
        ylabel('Y');
        legend;
        grid on;
    end
end
