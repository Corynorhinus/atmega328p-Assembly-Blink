;
; assemblytest.asm
;
; Created: 25.01.2021 12:40:46
; Author : dogukan bicer
;


.ORG 0x0000            ; bir sonraki talimat adres 0x0000'a yazılıyor
                       ; 
rjmp basla             ; vektör resetlenip  "main" e geçiyor
basla:
ldi r16, low(RAMEND)   ; stack ayarları. (ramend r16 daki değerleri gecici olarak saklaması için)
out SPL, r16
ldi r16, high(RAMEND)
out SPH, r16
ldi r16, 0xFF          ; register 16 0xFF'e ayarlanıyor (tüm bitler 1)
out 0x0a, r16          ; değerler r16 (0xFF) in datasına yazılıyor DDRD=0x0a
                       ; Register d
tekrar:
  sbi PortD,2 ;   ledi söndür port d nin 2 pini yani d2 pini
 rcall tekrar_05       ; 1 saniye bekle
  cbi PortD,2       ; ledi yak
 rcall tekrar_05       ; 1 saniye bekle
  rjmp tekrar            ; döngüyü tekrarla

tekrar_05:              ; alt fonksiyon:
  ldi r16, 31       ; r16 yı 31 e yükle
dis_dongu:            ; Dış döngü
  ldi r24, low(1021)   ; register r24:r25'i 1021 e yükle
                       ; r24:r25 e "hemen değer ekle":
  ldi r25, high(1021)  ; register r24:r25'i 1021 e yükle
gecikme_dongu:         ; delay döngüsü
                       
  adiw r24, 1          ; register r24 e hemen 1 ekle
                      
  brne gecikme_dongu     ;
  dec r16              ; r16 yı düşür
  brne dis_dongu     ; dış döngü bitmemişse 
  ret                  ; alt fonksiyona geri dön
