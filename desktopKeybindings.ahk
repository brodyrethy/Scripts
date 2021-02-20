;Alphabet Keys
;;a
;;b
<#b::Run "C:\Program Files\Firefox Nightly\firefox.exe"
;<#<+b::Run C:\Program Files (x86)\Betternet\5.3.0.433\Betternet.exe
;;c
;;d
;;e
;;f
<#f::Send {f11}
;;g
<#g::Run C:\Users\skryoo\AppData\Local\GitHubDesktop\GitHubDesktop.exe
;;h
<#h::Run C:\Program Files\HexChat\hexchat.exe
<#^h::Send ^#{Left}
!h::Send {Left}
;;i
<#<+i::Run C:\tools\vim\vim82\gvim.exe Y:/GitHub/Scripts/desktopKeybindings.ahk
;;j
<#j::Send <#{Down}
!j::Send {Down}
;;k
<#k::Send <#{Up}
!k::Send {Up}
;;l
<#^l::Send ^#{Right}
!l::Send {Right}
;;m
;;n
;;o
;<#o::Run C:\Users\skryoo\AppData\Local\Microsoft\OneDrive\OneDrive.exe
;;p
<#p::Run "C:\Program Files\PuTTY\putty.exe"
<#<+p::Run C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
;<#<^p::Run C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
;<#!p::Run C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
^p::Send ^{p}
;;q
<#q::Run C:\Program Files\qBittorrent\qbittorrent.exe
<#<+q::Send !{f4}
;;r
;;s
<#s::Run C:\Program Files (x86)\SoulseekQt\SoulseekQT.exe
;<#<+s::Run C:\Program Files (x86)\SoulseekQt\SoulseekQT.exe
;<#<^s::Run C:\Program Files (x86)\SoulseekQt\SoulseekQT.exe
;<#!s::Run C:\Program Files (x86)\SoulseekQt\SoulseekQT.exe
;;t
<#t::Run C:\tools\vim\vim82\gvim.exe "Y:/notes/TODO.wiki"
;;u
;;v
<#v::Run C:\tools\vim\vim82\gvim.exe
;;w
;;x
;;y
^y::Send ^{c}
;;z

;Everything other than alphabet keys
;;F1-12 keys
;;;F1
$F1::
if (WinActive("ahk_class Progman") || WinActive("ahk_Class DV2ControlHost") || (WinActive("Start") && WinActive("ahk_class Button")) || WinActive("ahk_class Shell_TrayWnd")) ; disallows minimizing things that shouldn't be minimized, like the task bar and desktop
	return
WinGet, MinMax, MinMax, A
If (MinMax = 1)
	WinRestore, A
else
	WinMaximize, A
return
;;;F2
$F2::Send ^#{Down}
<#F2::Send {Volume_Down 1}
;;;F3
<#F3::Send {Volume_Up 1}
;;;F4
$F4::Send !{Tab}
<#F4::Send {Volume_Mute}
;;;F5
;$F5::Send ^{w}
<#F5::Run C:\Program Files (x86)\foobar2000\foobar2000.exe
;;;F6
$F6::Send !{f4}
<#F6::Run C:\Program Files (x86)\foobar2000\foobar2000.exe /prev
;;;F7
<#F7::Run C:\Program Files (x86)\foobar2000\foobar2000.exe /pause
;;;F8
$F8::Run C:\tools\vim\vim82\gvim.exe
<#F8::Run C:\Program Files (x86)\foobar2000\foobar2000.exe /next
;;;F9
$F9::Run C:\Program Files\Firefox Nightly\firefox.exe
;;;F10
$F10::Run C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
;;;F11
$F11::Send ^{PgUp}
;;;F12
$F12::Send ^{PgDn}

;;Capslock
Capslock::Escape

;;Enter
<#Enter::Run C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
<#<+Enter::Run C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe

;;Pause
$Pause::Send ^{w}
