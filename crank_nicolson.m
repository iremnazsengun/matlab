function boundary_value_error_table()
    % Adım boyutları
    h_values = [0.8, 0.4, 0.2, 0.1];
    
    % Hata vektörlerini saklamak için değişkenler
    errors_L2 = []; 
    errors_L1 = [];
    errors_Linf = [];
    
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
        
        % Hata hesaplama
        error_L2 = norm(Y_exact' - Y);
        error_L1 = norm(Y_exact' - Y, 1);
        error_Linf = norm(Y_exact' - Y, inf);
        
        % Hataları sakla
        errors_L2 = [errors_L2; error_L2];
        errors_L1 = [errors_L1; error_L1];
        errors_Linf = [errors_Linf; error_Linf];
    end
    
    % Yakınsama hızlarını hesapla
    rate_L2 = log(errors_L2(1:end-1) ./ errors_L2(2:end)) ./ log(h_values(1:end-1)' ./ h_values(2:end)');
    rate_L1 = log(errors_L1(1:end-1) ./ errors_L1(2:end)) ./ log(h_values(1:end-1)' ./ h_values(2:end)');
    rate_Linf = log(errors_Linf(1:end-1) ./ errors_Linf(2:end)) ./ log(h_values(1:end-1)' ./ h_values(2:end)');
    
    % Tablo oluştur
    fprintf('\n  h       ||E||_2      Rate(L2)   ||E||_1      Rate(L1)   ||E||_inf   Rate(Linf)\n');
    fprintf('-------------------------------------------------------------------------------\n');
    
    for i = 1:length(h_values)
        if i == length(h_values)
            fprintf('%0.2f   %0.6f      -        %0.6f      -        %0.6f      -\n', h_values(i), errors_L2(i), errors_L1(i), errors_Linf(i));
        else
            fprintf('%0.2f   %0.6f   %0.4f   %0.6f   %0.4f   %0.6f   %0.4f\n', h_values(i), errors_L2(i), rate_L2(i), errors_L1(i), rate_L1(i), errors_Linf(i), rate_Linf(i));
        end
    end
end