FasdUAS 1.101.10   ��   ��    k             i         I     ������
�� .aevtoappnull  �   � ****��  ��    k     � 	 	  
  
 l     ��  ��      Start or activate iTerm     �   0   S t a r t   o r   a c t i v a t e   i T e r m      r         m        �   
 e m p t y  o      ���� 	0 myvar        O    �    k    �       I   ������
�� .miscactvnull��� ��� null��  ��        l   ��������  ��  ��     ��  O    �     k    � ! !  " # " l   �� $ %��   $ ? 9 Create a new tab, which will create a new session inside    % � & & r   C r e a t e   a   n e w   t a b ,   w h i c h   w i l l   c r e a t e   a   n e w   s e s s i o n   i n s i d e #  ' ( ' r     ) * ) l    +���� + I   ������
�� .Itrmntwnnull���     obj ��  ��  ��  ��   * o      ���� 0 newtab newTab (  , - , l   �� . /��   . Q K Since we just created the tab, there should only be one session right now.    / � 0 0 �   S i n c e   w e   j u s t   c r e a t e d   t h e   t a b ,   t h e r e   s h o u l d   o n l y   b e   o n e   s e s s i o n   r i g h t   n o w . -  1�� 1 O    � 2 3 2 X   ! � 4�� 5 4 O   3 { 6 7 6 k   7 z 8 8  9 : 9 n  7 = ; < ; I   8 =�� =���� 0 waitforwindow waitForWindow =  >�� > m   8 9 ? ? � @ @ 
 i T e r m��  ��   <  f   7 8 :  A B A I  > E���� C
�� .Itrmsntxnull���     obj ��   C �� D��
�� 
Text D m   @ A E E � F F  s c r e e n��   B  G H G I  F K�� I��
�� .sysodelanull��� ��� nmbr I m   F G���� ��   H  J K J I  L U���� L
�� .Itrmsntxnull���     obj ��   L �� M��
�� 
Text M m   N Q N N � O O   ��   K  P Q P I  V [�� R��
�� .sysodelanull��� ��� nmbr R m   V W���� ��   Q  S T S O   \ p U V U I  b o�� W X
�� .prcskprsnull���     ctxt W m   b e Y Y � Z Z  a X �� [��
�� 
faal [ m   h k��
�� eMdsKctl��   V m   \ _ \ \�                                                                                  sevs  alis    �  Macintosh HD               Ѻ�ZH+     *System Events.app                                               �W�2�'        ����  	                CoreServices    ѻ�      �2�w       *        =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��   T  ]�� ] I  q z���� ^
�� .Itrmsntxnull���     obj ��   ^ �� _��
�� 
Text _ m   s v ` ` � a a 2 h a r d s t a t u s   a l w a y s l a s t l i n e��  ��   7 o   3 4���� 0 asession aSession�� 0 asession aSession 5 2  $ '��
�� 
Trms 3 o    ���� 0 newtab newTab��     l    b���� b 4   �� c
�� 
cwin c m    ���� ��  ��  ��    m     d d�                                                                                  ITRM  alis    H  Macintosh HD               Ѻ�ZH+     �	iTerm.app                                                      s��|g�        ����  	                Applications    ѻ�      �|�:       �  $Macintosh HD:Applications: iTerm.app   	 i T e r m . a p p    M a c i n t o s h   H D  Applications/iTerm.app  / ��     e�� e l  � ���������  ��  ��  ��     f g f l     ��������  ��  ��   g  h i h l     �� j k��   j , & Waits for a window to come into focus    k � l l L   W a i t s   f o r   a   w i n d o w   t o   c o m e   i n t o   f o c u s i  m�� m i     n o n I      �� p���� 0 waitforwindow waitForWindow p  q�� q o      ���� 0 appname appName��  ��   o k     9 r r  s t s l     �� u v��   u 0 * Poll until "appName" is the active window    v � w w T   P o l l   u n t i l   " a p p N a m e "   i s   t h e   a c t i v e   w i n d o w t  x y x r      z { z m      | | � } } 
 n o A p p { o      ���� 0 	activeapp 	activeApp y  ~�� ~ W    9  �  k    4 � �  � � � r     � � � l    ����� � I   �� � �
�� .earsffdralis        afdr � m    ��
�� appfegfp � �� ���
�� 
rtyp � m    ��
�� 
utxt��  ��  ��   � o      ���� 0 	activeapp 	activeApp �  � � � l   �� � ���   � ; 5 If the active app name does not contain the target,     � � � � j   I f   t h e   a c t i v e   a p p   n a m e   d o e s   n o t   c o n t a i n   t h e   t a r g e t ,   �  � � � l   �� � ���   �    try to activate it again.    � � � � 4   t r y   t o   a c t i v a t e   i t   a g a i n . �  � � � Z    . � ��� � � H     � � E    � � � o    ���� 0 	activeapp 	activeApp � o    ���� 0 appname appName � O    * � � � I  $ )������
�� .miscactvnull��� ��� null��  ��   � 4    !�� �
�� 
capp � o     ���� 0 appname appName��   � k   - . � �  � � � l  - -�� � ���   �   Done    � � � � 
   D o n e �  ��� �  S   - .��   �  ��� � I  / 4�� ���
�� .sysodelanull��� ��� nmbr � m   / 0 � � ?���������  ��   � =    � � � o    	���� 0 	activeapp 	activeApp � o   	 
���� 0 appname appName��  ��       �� � � ���   � ����
�� .aevtoappnull  �   � ****�� 0 waitforwindow waitForWindow � �� ���� � ���
�� .aevtoappnull  �   � ****��  ��   � ���� 0 asession aSession �  �� d���������������� ?���� E���� N \ Y������ `�� 	0 myvar  
�� .miscactvnull��� ��� null
�� 
cwin
�� .Itrmntwnnull���     obj �� 0 newtab newTab
�� 
Trms
�� 
kocl
�� 
cobj
�� .corecnte****       ****�� 0 waitforwindow waitForWindow
�� 
Text
�� .Itrmsntxnull���     obj 
�� .sysodelanull��� ��� nmbr
�� 
faal
�� eMdsKctl
�� .prcskprsnull���     ctxt�� ��E�O� |*j O*�k/ n*j E�O� a ^*�-[��l 
kh  � E)�k+ O*��l Okj O*�a l Okj Oa  a a a l UO*�a l U[OY��UUUOP � �� o���� � ����� 0 waitforwindow waitForWindow�� �� ���  �  ���� 0 appname appName��   � ����� 0 appname appName� 0 	activeapp 	activeApp � 	 |�~�}�|�{�z�y ��x
�~ appfegfp
�} 
rtyp
�| 
utxt
�{ .earsffdralis        afdr
�z 
capp
�y .miscactvnull��� ��� null
�x .sysodelanull��� ��� nmbr�� :�E�O 4h�� ���l E�O�� *�/ *j UY O�j [OY�� ascr  ��ޭ