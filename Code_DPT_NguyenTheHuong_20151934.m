%Bai tap da phuong tien chuong 1
%sinh vien Nguyen The Huong 20151934
%bai1
r= audiorecorder(44100,16,1);
disp('bat dau ghi am');
recordblocking(r,10);
disp('ket thuc');
g = getaudiodata(r,'int16');
audiowrite('orig_input.wav',g,44100);
y= audioread('orig_input.wav');
%bai2
fs = 44100; % tan so lay mau (Hz)
t = 1/fs : 1/fs : 0.158;
fla2 = 880; % tan so cac not nhac
fsol2 = 792;
ffa2 = 704;
fmi2 = 660;
fre2 = 586;
fdo2 = 528;
fsi = 495;
fla = 440;
fsol = 396;
ffa = 352;
fmi = 330;
fre = 293;
fdo = 264;
fla0 = 220;
fre0 = 146.5;
ffa0 = 176;
    
A0 = .7;
A1 = .6; A2 = .5; A3 = .4; A4 = .3; A5 = .2; A6 = .1;   % bien do
	
w = 0; % pha

la2 = A1 *sin( 2 * pi * fla2 * t + w );
sol2 = A2 *sin( 2 * pi * fsol2 * t + w );
fa2 = A3 *sin( 2 * pi * ffa2 * t + w );
mi2 = A4 *sin( 2 * pi * fmi2 * t + w );
re2 = A5 *sin( 2 * pi * fre2 * t + w );
do2 = A6 *sin( 2 * pi * fdo2 * t + w );
si = A0 *sin( 2 * pi * fsi * t + w );
la = A1 *sin( 2 * pi * fla * t + w );
sol = A2 *sin( 2 * pi * fsol * t + w );
fa = A3 *sin( 2 * pi * ffa * t + w );
mi = A4 *sin( 2 * pi * fmi * t + w );
re = A5 *sin( 2 * pi * fre * t + w );
do = A6 *sin( 2 * pi * fdo * t + w );
fa0 = A3 *sin( 2 * pi * ffa0 * t + w );
re0 = A5 *sin( 2 * pi * fre0 * t + w );
la0 = A1 *sin( 2 * pi * fla0 * t + w );

y5 = [re0 la do2 la re0 fa re0 fa re0 fa0 la2 la sol la fa re0 la0 do2 re2 re2 re2 la0 do2 do2 re2 do2 re0 la la fa0 sol sol sol fa sol la2 do2 re2];


y= audioread('orig_input.wav');
x1 = y';
x2 = x1(1: length(y5));
y6 = y5 + x2;
audiowrite('melody.wav',y6,fs);

%bai3
N = length(y6); % number of FFT points
transform = fft(y6,N)/N;
magTransform = abs(transform);

faxis = linspace(-N/2,N/2,N);
figure(1);
plot(faxis,fftshift(magTransform));
title('The Spectrum');
xlabel('Frequency (Hz)');



%bai4
figure(2);
win = 128; % window length in samples
% number of samples between overlapping windows:
hop = win/2;            

nfft = win; % width of each frequency bin 
spectrogram(y6,win,hop,nfft,fs,'yaxis');
yt = get(gca,'YTick');  
set(gca,'YTickLabel', sprintf('%.0f|',yt));
title('Spectrogram');