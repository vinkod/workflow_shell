FasdUAS 1.101.10   ��   ��    k             l     ��  ��    ^ X Take two parameters, the user's password and the portal/gateway they need to connect to     � 	 	 �   T a k e   t w o   p a r a m e t e r s ,   t h e   u s e r ' s   p a s s w o r d   a n d   t h e   p o r t a l / g a t e w a y   t h e y   n e e d   t o   c o n n e c t   t o   
  
 i         I     �� ��
�� .aevtoappnull  �   � ****  J             o      ���� 0 	apassword 	aPassword   ��  o      ���� 0 aportal aPortal��  ��    k     U       l     ��  ��    V P Use the local user as the username... This may need to be changed in the future     �   �   U s e   t h e   l o c a l   u s e r   a s   t h e   u s e r n a m e . . .   T h i s   m a y   n e e d   t o   b e   c h a n g e d   i n   t h e   f u t u r e      r         I    �� ��
�� .sysoexecTEXT���     TEXT  m        �    w h o a m i��    o      ���� 0 username userName     !   l   ��������  ��  ��   !  " # " l   �� $ %��   $   Start or activate iTerm    % � & & 0   S t a r t   o r   a c t i v a t e   i T e r m #  '�� ' O    U ( ) ( k    T * *  + , + I   ������
�� .miscactvnull��� ��� null��  ��   ,  - . - l   �� / 0��   / 2 , Wait for it to start and come into focus...    0 � 1 1 X   W a i t   f o r   i t   t o   s t a r t   a n d   c o m e   i n t o   f o c u s . . . .  2 3 2 l   �� 4 5��   4 L F NOTE: This may not be necessary, since it has its own AppleScript API    5 � 6 6 �   N O T E :   T h i s   m a y   n o t   b e   n e c e s s a r y ,   s i n c e   i t   h a s   i t s   o w n   A p p l e S c r i p t   A P I 3  7 8 7 n    9 : 9 I    �� ;���� 0 waitforwindow waitForWindow ;  <�� < m     = = � > > 
 i T e r m��  ��   :  f     8  ? @ ? l   ��������  ��  ��   @  A B A l   �� C D��   C "  I don't know what this does    D � E E 8   I   d o n ' t   k n o w   w h a t   t h i s   d o e s B  F G F l   �� H I��   H ` Zset myterm to (make new terminal) -- dont remember what this does, commenting out for now.    I � J J � s e t   m y t e r m   t o   ( m a k e   n e w   t e r m i n a l )   - -   d o n t   r e m e m b e r   w h a t   t h i s   d o e s ,   c o m m e n t i n g   o u t   f o r   n o w . G  K�� K O    T L M L k     S N N  O P O l     �� Q R��   Q   Open a new session    R � S S &   O p e n   a   n e w   s e s s i o n P  T U T I    '���� V
�� .ITRMLNCHPssn       obj ��   V �� W��
�� 
Pssn W m   " # X X � Y Y  D e f a u l t   S e s s i o n��   U  Z [ Z l  ( (�� \ ]��   \    Send text to that session    ] � ^ ^ 4   S e n d   t e x t   t o   t h a t   s e s s i o n [  _�� _ O   ( S ` a ` k   / R b b  c d c l  / /�� e f��   e   Connect to the portal    f � g g ,   C o n n e c t   t o   t h e   p o r t a l d  h i h I  / <���� j
�� .ITRMWrtenull���    obj ��   j �� k��
�� 
iTxt k b   1 8 l m l b   1 6 n o n b   1 4 p q p m   1 2 r r � s s  s s h   q o   2 3���� 0 username userName o m   4 5 t t � u u  @ m o   6 7���� 0 aportal aPortal��   i  v w v l  = =�� x y��   x   Wait for the connection    y � z z 0   W a i t   f o r   t h e   c o n n e c t i o n w  { | { I  = B�� }��
�� .sysodelanull��� ��� nmbr } m   = >���� ��   |  ~  ~ l  C C�� � ���   �   Enter the password    � � � � &   E n t e r   t h e   p a s s w o r d   � � � I  C J���� �
�� .ITRMWrtenull���    obj ��   � �� ���
�� 
iTxt � o   E F���� 0 	apassword 	aPassword��   �  � � � l  K K�� � ���   � * $ Grace period, may not be necessary.    � � � � H   G r a c e   p e r i o d ,   m a y   n o t   b e   n e c e s s a r y . �  ��� � I  K R�� ���
�� .sysodelanull��� ��� nmbr � m   K N � � ?�      ��  ��   a l  ( , ����� � 4  ( ,�� �
�� 
Pssn � m   * +��������  ��  ��   M l    ����� � 4   �� �
�� 
Ptrm � m    ���� ��  ��  ��   ) m    	 � ��                                                                                  ITRM  alis    H  Macintosh HD               Ѻ�ZH+     �	iTerm.app                                                       �g�7H<        ����  	                Applications    ѻ�      �7��       �  $Macintosh HD:Applications: iTerm.app   	 i T e r m . a p p    M a c i n t o s h   H D  Applications/iTerm.app  / ��  ��     � � � l     ��������  ��  ��   �  � � � l     �� � ���   � , & Waits for a window to come into focus    � � � � L   W a i t s   f o r   a   w i n d o w   t o   c o m e   i n t o   f o c u s �  ��� � i     � � � I      �� ����� 0 waitforwindow waitForWindow �  ��� � o      ���� 0 appname appName��  ��   � k     1 � �  � � � l     �� � ���   � 0 * Poll until "appName" is the active window    � � � � T   P o l l   u n t i l   " a p p N a m e "   i s   t h e   a c t i v e   w i n d o w �  � � � r      � � � m      � � � � � 
 n o A p p � o      ���� 0 	activeapp 	activeApp �  ��� � W    1 � � � k    , � �  � � � r     � � � l    ����� � I   �� � �
�� .earsffdralis        afdr � m    ��
�� appfegfp � �� ���
�� 
rtyp � m    ��
�� 
utxt��  ��  ��   � o      ���� 0 	activeapp 	activeApp �  � � � l   �� � ���   � ; 5 If the active app name does not contain the target,     � � � � j   I f   t h e   a c t i v e   a p p   n a m e   d o e s   n o t   c o n t a i n   t h e   t a r g e t ,   �  � � � l   �� � ���   �    try to activate it again.    � � � � 4   t r y   t o   a c t i v a t e   i t   a g a i n . �  ��� � Z    , � ��� � � H     � � E    � � � o    ���� 0 	activeapp 	activeApp � o    ���� 0 appname appName � k    ( � �  � � � I   "�� ���
�� .sysodelanull��� ��� nmbr � m     � � ?���������   �  ��� � I  # (������
�� .miscactvnull��� ��� null��  ��  ��  ��   � k   + , � �  � � � l  + +�� � ���   �   Done    � � � � 
   D o n e �  ��� �  S   + ,��  ��   � =    � � � o    	���� 0 	activeapp 	activeApp � o   	 
���� 0 appname appName��  ��       �� � � ���   � ����
�� .aevtoappnull  �   � ****�� 0 waitforwindow waitForWindow � �� ���� � ���
�� .aevtoappnull  �   � ****�� �� ���  �  ������ 0 	apassword 	aPassword�� 0 aportal aPortal��   � ������ 0 	apassword 	aPassword�� 0 aportal aPortal �  ���� ��� =������ X���� r t������ �
�� .sysoexecTEXT���     TEXT�� 0 username userName
�� .miscactvnull��� ��� null�� 0 waitforwindow waitForWindow
�� 
Ptrm
�� 
Pssn
�� .ITRMLNCHPssn       obj 
�� 
iTxt
�� .ITRMWrtenull���    obj �� 
�� .sysodelanull��� ��� nmbr�� V�j E�O� J*j O)�k+ O*�k/ 5*��l 
O*�i/ %*���%�%�%l O�j O*�l Oa j UUU � �� ����� � ���� 0 waitforwindow waitForWindow�� �~ ��~  �  �}�} 0 appname appName��   � �|�{�| 0 appname appName�{ 0 	activeapp 	activeApp �  ��z�y�x�w ��v�u
�z appfegfp
�y 
rtyp
�x 
utxt
�w .earsffdralis        afdr
�v .sysodelanull��� ��� nmbr
�u .miscactvnull��� ��� null� 2�E�O ,h�� ���l E�O�� �j O*j Y [OY�� ascr  ��ޭ