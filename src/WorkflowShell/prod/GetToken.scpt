FasdUAS 1.101.10   ��   ��    k             i         I     �� 	��
�� .aevtoappnull  �   � **** 	 o      ���� 0 apin aPin��    k     � 
 
     Z     �  ��   ?        n         1    ��
�� 
leng  o     ���� 0 apin aPin  m    ����    k    �       l   ��  ��     set thePin to aPin     �   $ s e t   t h e P i n   t o   a P i n      r        m    	   �    S e c u r I D  o      ���� 0 appname appName     !   l   ��������  ��  ��   !  " # " l   �� $ %��   $ ; 5 Check if SecurID is already started. If so, kill it.    % � & & j   C h e c k   i f   S e c u r I D   i s   a l r e a d y   s t a r t e d .   I f   s o ,   k i l l   i t . #  ' ( ' l   �� ) *��   ) 9 3 We are doing this because there is no way to tell     * � + + f   W e   a r e   d o i n g   t h i s   b e c a u s e   t h e r e   i s   n o   w a y   t o   t e l l   (  , - , l   �� . /��   . > 8 which button or field in SecurID is currently in focus.    / � 0 0 p   w h i c h   b u t t o n   o r   f i e l d   i n   S e c u r I D   i s   c u r r e n t l y   i n   f o c u s . -  1 2 1 l   �� 3 4��   3 @ : Killing it and reopening it will focus the pin entry box.    4 � 5 5 t   K i l l i n g   i t   a n d   r e o p e n i n g   i t   w i l l   f o c u s   t h e   p i n   e n t r y   b o x . 2  6 7 6 r     8 9 8 I    ��������  0 getprocesslist getProcessList��  ��   9 o      ���� 0 processlist ProcessList 7  : ; : O    3 < = < k    2 > >  ? @ ? l   �� A B��   A . (set ProcessList to name of every process    B � C C P s e t   P r o c e s s L i s t   t o   n a m e   o f   e v e r y   p r o c e s s @  D�� D Z    2 E F���� E E    G H G o    ���� 0 processlist ProcessList H o    ���� 0 appname appName F k    . I I  J K J r    & L M L n    $ N O N 1   " $��
�� 
idux O 4    "�� P
�� 
prcs P o     !���� 0 appname appName M o      ���� 0 thepid ThePID K  Q�� Q I  ' .�� R��
�� .sysoexecTEXT���     TEXT R b   ' * S T S m   ' ( U U � V V  k i l l   - K I L L   T o   ( )���� 0 thepid ThePID��  ��  ��  ��  ��   = m     W W�                                                                                  sevs  alis    �  Macintosh HD               Ѻ�ZH+     *System Events.app                                               �W�2�'        ����  	                CoreServices    ѻ�      �2�w       *        =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��   ;  X Y X l  4 4��������  ��  ��   Y  Z [ Z l  4 4�� \ ]��   \ + % Wait until SecurID finishes closing.    ] � ^ ^ J   W a i t   u n t i l   S e c u r I D   f i n i s h e s   c l o s i n g . [  _ ` _ r   4 ; a b a I   4 9��������  0 getprocesslist getProcessList��  ��   b o      ���� 0 processlist ProcessList `  c d c W   < Q e f e r   E L g h g I   E J��������  0 getprocesslist getProcessList��  ��   h o      ���� 0 processlist ProcessList f H   @ D i i E  @ C j k j o   @ A���� 0 processlist ProcessList k o   A B���� 0 appname appName d  l m l l  R R��������  ��  ��   m  n o n l  R R��������  ��  ��   o  p q p l  R R�� r s��   r   Start it up again.    s � t t &   S t a r t   i t   u p   a g a i n . q  u v u l  R Z w x y w I  R Z�� z��
�� .miscactvnull��� ��� null z 4   R V�� {
�� 
capp { o   T U���� 0 appname appName��   x   restart app    y � | |    r e s t a r t   a p p v  } ~ } l  [ [��������  ��  ��   ~   �  l  [ [�� � ���   � #  Wait until it is open again.    � � � � :   W a i t   u n t i l   i t   i s   o p e n   a g a i n . �  � � � r   [ b � � � I   [ `��������  0 getprocesslist getProcessList��  ��   � o      ���� 0 processlist ProcessList �  � � � W   c w � � � r   k r � � � I   k p��������  0 getprocesslist getProcessList��  ��   � o      ���� 0 processlist ProcessList � E  g j � � � o   g h���� 0 processlist ProcessList � o   h i���� 0 appname appName �  � � � l  x x��������  ��  ��   �  ��� � O   x � � � � k    � � �  � � � l   �� � ���   � !  Try to activate the window    � � � � 6   T r y   t o   a c t i v a t e   t h e   w i n d o w �  � � � I   �������
�� .miscactvnull��� ��� null��  ��   �  � � � l  � ���������  ��  ��   �  � � � n  � � � � � I   � ��� ����� 0 waitforwindow waitForWindow �  ��� � o   � ����� 0 appname appName��  ��   �  f   � � �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �   Mush buttons in the app    � � � � 0   M u s h   b u t t o n s   i n   t h e   a p p �  � � � O   � � � � � k   � � � �  � � � l  � � � � � � I  � ��� ���
�� .prcskprsnull���     ctxt � o   � ����� 0 apin aPin��   �   type the pin number    � � � � (   t y p e   t h e   p i n   n u m b e r �  � � � l  � � � � � � I  � ��� ���
�� .prcskcodnull���     **** � m   � ����� $��   �   return key    � � � �    r e t u r n   k e y �  � � � l  � � � � � � I  � ��� ���
�� .sysodelanull��� ��� nmbr � m   � � � � ?�333333��   �   wait for token appear    � � � � ,   w a i t   f o r   t o k e n   a p p e a r �  � � � l  � � � � � � I  � ��� ���
�� .prcskcodnull���     **** � m   � ����� 0��   �  
 press tab    � � � �    p r e s s   t a b �  ��� � l  � � � � � � I  � ��� ���
�� .prcskcodnull���     **** � m   � ����� 1��   � %  space (to hit the copy button)    � � � � >   s p a c e   ( t o   h i t   t h e   c o p y   b u t t o n )��   � m   � � � ��                                                                                  sevs  alis    �  Macintosh HD               Ѻ�ZH+     *System Events.app                                               �W�2�'        ����  	                CoreServices    ѻ�      �2�w       *        =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � l f Sometimes calling "the clipboard" right after you put something on it causes applescript to go crazy.    � � � � �   S o m e t i m e s   c a l l i n g   " t h e   c l i p b o a r d "   r i g h t   a f t e r   y o u   p u t   s o m e t h i n g   o n   i t   c a u s e s   a p p l e s c r i p t   t o   g o   c r a z y . �  � � � l  � ��� � ���   � T N The best solution seems to be to delay a bit between copy and get operations.    � � � � �   T h e   b e s t   s o l u t i o n   s e e m s   t o   b e   t o   d e l a y   a   b i t   b e t w e e n   c o p y   a n d   g e t   o p e r a t i o n s . �  � � � I  � ��� ���
�� .sysodelanull��� ��� nmbr � m   � ����� ��   �  � � � r   � � � � � I  � �������
�� .JonsgClp****    ��� null��  ��   � o      ���� 	0 token   �  � � � L   � � � � o   � ����� 	0 token   �  ��� � l  � ���������  ��  ��  ��   � 4   x |�� �
�� 
capp � o   z {���� 0 appname appName��  ��    I  � ��� ��
�� .sysodlogaskr        TEXT � m   � � � � � � � X Y o u   m u s t   p r o v i d e   a   v a l i d   P I N   a s   a n   a r g u m e n t .�     ��~ � L   � � � � o   � ��}�} 	0 token  �~     � � � l     �|�{�z�|  �{  �z   �  � � � i     � � � I      �y�x�w�y  0 getprocesslist getProcessList�x  �w   � k      � �  � � � O      � � � r     � � � n    	 �  � 1    	�v
�v 
pnam  2    �u
�u 
prcs � o      �t�t 0 processlist ProcessList � m     �                                                                                  sevs  alis    �  Macintosh HD               Ѻ�ZH+     *System Events.app                                               �W�2�'        ����  	                CoreServices    ѻ�      �2�w       *        =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��   � �s L     o    �r�r 0 processlist ProcessList�s   �  l     �q�p�o�q  �p  �o    i    	 I      �n
�m�n 0 waitforwindow waitForWindow
 �l o      �k�k 0 appname appName�l  �m  	 k     1  l     �j�j   0 * Poll until "appName" is the active window    � T   P o l l   u n t i l   " a p p N a m e "   i s   t h e   a c t i v e   w i n d o w  r      m      � 
 n o A p p o      �i�i 0 	activeapp 	activeApp �h W    1 k    ,  r     l    �g�f  I   �e!"
�e .earsffdralis        afdr! m    �d
�d appfegfp" �c#�b
�c 
rtyp# m    �a
�a 
utxt�b  �g  �f   o      �`�` 0 	activeapp 	activeApp $%$ l   �_&'�_  & ; 5 If the active app name does not contain the target,    ' �(( j   I f   t h e   a c t i v e   a p p   n a m e   d o e s   n o t   c o n t a i n   t h e   t a r g e t ,  % )*) l   �^+,�^  +    try to activate it again.   , �-- 4   t r y   t o   a c t i v a t e   i t   a g a i n .* .�]. Z    ,/0�\1/ H    22 E   343 o    �[�[ 0 	activeapp 	activeApp4 o    �Z�Z 0 appname appName0 k    (55 676 I   "�Y8�X
�Y .sysodelanull��� ��� nmbr8 m    99 ?��������X  7 :�W: I  # (�V�U�T
�V .miscactvnull��� ��� null�U  �T  �W  �\  1  S   + ,�]   =   ;<; o    	�S�S 0 	activeapp 	activeApp< o   	 
�R�R 0 appname appName�h   =>= l     �Q�P�O�Q  �P  �O  > ?�N? l     �M�L�K�M  �L  �K  �N       �J@ABC DE�I�H�G�F�E�D�J  @ �C�B�A�@�?�>�=�<�;�:�9�8
�C .aevtoappnull  �   � ****�B  0 getprocesslist getProcessList�A 0 waitforwindow waitForWindow�@ 0 appname appName�? 0 processlist ProcessList�> 	0 token  �= 0 thepid ThePID�<  �;  �:  �9  �8  A �7 �6�5FG�4
�7 .aevtoappnull  �   � ****�6 0 apin aPin�5  F �3�3 0 apin aPinG �2 �1�0�/ W�.�-�, U�+�*�)�(�'�&�% ��$�#�"�!�  ��
�2 
leng�1 0 appname appName�0  0 getprocesslist getProcessList�/ 0 processlist ProcessList
�. 
prcs
�- 
idux�, 0 thepid ThePID
�+ .sysoexecTEXT���     TEXT
�* 
capp
�) .miscactvnull��� ��� null�( 0 waitforwindow waitForWindow
�' .prcskprsnull���     ctxt�& $
�% .prcskcodnull���     ****
�$ .sysodelanull��� ��� nmbr�# 0�" 1
�! .JonsgClp****    ��� null�  	0 token  
� .sysodlogaskr        TEXT�4 ܠ�,j ��E�O*j+ E�O� �� *��/�,E�O��%j 
Y hUO*j+ E�O h��*j+ E�[OY��O*��/j O*j+ E�O h��*j+ E�[OY��O*��/ N*j O)�k+ O� %�j O�j Oa j Oa j Oa j UOkj O*j E` O_ OPUY 	a j O_ B � ���HI��  0 getprocesslist getProcessList�  �  H �� 0 processlist ProcessListI ��
� 
prcs
� 
pnam� � 	*�-�,E�UO�C �	��JK�� 0 waitforwindow waitForWindow� �L� L  �� 0 appname appName�  J ��� 0 appname appName� 0 	activeapp 	activeAppK ����9��

� appfegfp
� 
rtyp
� 
utxt
� .earsffdralis        afdr
� .sysodelanull��� ��� nmbr
�
 .miscactvnull��� ��� null� 2�E�O ,h�� ���l E�O�� �j O*j Y [OY��D �	M�	 PM P NOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~������������������������������N ���  l o g i n w i n d o wO ���  A R D A g e n tP ���  U s e r E v e n t A g e n tQ ���  A i r P l a y U I A g e n tR ���  F l u xS ���  R e c e i v e r H e l p e rT ���  S e r v i c e R e c o r d sU ���  T I S w i t c h e rV ��� 8 K e y c h a i n   C i r c l e   N o t i f i c a t i o nW ��� $ N o t i f i c a t i o n C e n t e rX ���  D o c kY ���  S y s t e m U I S e r v e rZ ��� $ C r a s h P l a n   m e n u   b a r[ ���  M e n u l e t\ ���  M c A f e e   R e p o r t e r] ���  A l f r e d   2^ ���  F i n d e r_ ��� 6 A n d r o i d   F i l e   T r a n s f e r   A g e n t` ���  s h a r i n g da ��� $ U S B O v e r d r i v e H e l p e rb ���  c l o u d p h o t o s dc ���  A u t h M a n a g e r _ M a cd ��� 4 c o m . a p p l e . i n t e r n e t a c c o u n t se ���  W i F i A g e n tf ��� ( c o m . a p p l e . d o c k . e x t r ag ���  L a t e r A g e n th ���  S p o t l i g h ti ���  T e r m i n a lj ��� 
 i T e r mk ���  f i r e f o xl ���  G o o g l e   C h r o m em ��� 
 S l a c kn ��� ( G o o g l e   C h r o m e   H e l p e ro ��� ( G o o g l e   C h r o m e   H e l p e rp ���  i d e aq ���  M i c r o s o f t   L y n cr ��� & M i c r o s o f t   A U   D a e m o ns ��� * c o m . a p p l e . q t k i t s e r v e rt ���  K e e P a s s Xu ��� " M i c r o s o f t   O u t l o o kv ��� 2 M i c r o s o f t   D a t a b a s e   D a e m o nw ��� . M i c r o s o f t   A l e r t s   D a e m o nx ���  S u b l i m e   T e x t   2y ���  n b a g e n tz ���  S p o t i f y{ ���  S p o t i f y   H e l p e r| ��� & E s c r o w S e c u r i t y A l e r t} ���  S C I M~ ��� N C i s c o   A n y C o n n e c t   S e c u r e   M o b i l i t y   C l i e n t ���  s t o r e u i d� ���  S a f a r i� ��� 6 c o m . a p p l e . W e b K i t . W e b C o n t e n t� ��� 6 c o m . a p p l e . W e b K i t . N e t w o r k i n g� ��� 
 A d i u m� ���  i T u n e s H e l p e r� ���  D r o p b o x� ���  g a r c o n� ���  g a r c o n� ��� . I m a g e   C a p t u r e   E x t e n s i o n� ���  G o o g l e   D r i v e� ���  J a v a   U p d a t e r� ��� ( G o o g l e   C h r o m e   H e l p e r� ��� 4 c o m . a p p l e . W e b K i t . P l u g i n . 6 4� ���  V O X A g e n t� ��� 0 M i c r o s o f t   R e m o t e   D e s k t o p� ���  r u b y m i n e� ��� ( G o o g l e   C h r o m e   H e l p e r� ��� ( G o o g l e   C h r o m e   H e l p e r� ���  S c r i p t   E d i t o r� ��� 0 c o m . a p p l e . s e c u r i t y . p b o x d� ��� ( G o o g l e   C h r o m e   H e l p e r� ��� ( G o o g l e   C h r o m e   H e l p e r� ��� 4 D o c u m e n t P o p o v e r V i e w S e r v i c e� ���  g a r c o n� ���  B e t t e r T o u c h T o o l� ���  B T T R e l a u n c h� ��� ( G o o g l e   C h r o m e   H e l p e r� ���  S y s t e m   E v e n t s� ���  o s a s c r i p t� ���  S e c u r I DE ���  7 0 5 6 3 7 0 7�I  (<�H  �G  �F  �E  �D   ascr  ��ޭ