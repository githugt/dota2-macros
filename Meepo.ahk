; Avoids checking empty variables to see if they are environment variables
; Recommended for performance and compatibility with future AutoHotkey releases
#NoEnv

; Ensures that there is only a single instance of this script running
#SingleInstance, Force

; Global declared variables

SCRIPT__TEMPORARILY_SUSPENDED := False
DELAY := 1.00
HAS__BLINK_DAGGER := False
HAS__GUINSOO := False
HAS__ACTIVE_ITEM_3 := False
HAS__AGHANIM := False
HAS__MANTA := False
MIN__MEEPOS := 1 ; This variable isn't being used right now
MAX__MEEPOS := 4
LOWEST_MAX_POSSIBLE__MEEPOS := 4
; Not going to include the possibility of manta + other sources of Illusions / Copies
MAX__POSSIBLE__MEEPOS := 7

BLINK_DAGGER__KEY := "z"
GUINSOO__KEY = "x"
ACTIVE_ITEM_3__KEY = "c"
POOF__KEY := "w"
EARTHBIND__KEY := "q"
NEXT_MEEPO__KEY := "Tab"
PRIMARY_MEEPO__KEY := "F1"

MEEPO_COUNT := 1


; Key Binds

; Poof all meepos. Primary meepo included
r::
	Gosub, POOF__ALL_MEEPOS
	Return

; Poof all other meepos
Space & r::
	Gosub, POOF__ALL_EXCEPT_MAIN_MEEPO
	Return

; Poof main meepo with items
; Click r near target then this 
e::
	USE__BLINK()
	USE__GUINSOO()
	USE__ACTIVE_ITEM_3() ; Expected to be Ethereal / BloodThorn
	Gosub, POOF__MAIN_MEEPO
	Return

; ALL IN ATTACK
; With this you blink and then use items and then bring in the army
Space & e::
	;USE__BLINK()
	;USE__GUINSOO()
	;USE__ACTIVE_ITEM_3() ; Expected to be Ethereal / BloodThorn
	Gosub, POOF__ALL_MEEPOS
	Return

; Toggle Earthbind
Space & q::
	Gosub, TOGGLE__EARTHBIND
	Return

NumpadAdd::
	if(MEEPO_COUNT >= MAX__MEEPOS){
	Return
	}
	MEEPO_COUNT += 1
	Gosub, ShowOverlay
	SetTimer, HideOverlay, 1000
	Return

NumpadSub::
	if(MEEPO_COUNT <= 1){
	Return
	}
	MEEPO_COUNT -= 1
	Gosub, ShowOverlay
	SetTimer, HideOverlay, 1000
	Return


Numpad7::
	TOGGLE__BLINK()
	Return

Numpad8::
	TOGGLE__GUINSOO()
	Return

Numpad9::
	TOGGLE__ACTIVE_ITEM_3()
	Return

Numpad4::
	TOGGLE__AGHANIM()
	Return

Numpad6::
	TOGGLE__MANTA()
	Return


;; This is to disable hotkey while typing in chat etc. And then reenable it after typing in chat
;Enter::
;	If (A_IsSuspended = 0)
;	{
;		SUSPEND__SCRIPT()
;	}
;	Else
;	{
;		If (SCRIPT__TEMPORARILY_SUSPENDED)
;		{
;			UNSUSPEND__SCRIPT()
;		}
;	}
;	Send, Enter
;	Return
;
;; This is to eenable the script if you choose to press escape in chat.
;; Obviously there are still many ways to cancel the chat input without enabling
;; Toggle the script if it does happen (Numpad5)
;Escape::
;	Suspend, Permit
;	If (A_IsSuspended = 0 And SCRIPT__TEMPORARILY_SUSPENDED)
;	{
;		UNSUSPEND__SCRIPT()
;	}
;	Return
;
;Numpad5::
;	TOGGLE__SUSPEND()
;	Return
;
;; Reload scrip.
;; Note that this would set all values to its default. (Includes meepo number would then be set to 1)
;Space & Numpad5::
;	RELOAD__SCRIPT()
;	Return
;
;; This should completely kills the running script. Script needs to be restarted from windows / shell.
;Space & Pause::
;	KILL__SCRIPT()
;	Return





; For Debugging
ShowOverlay:
	Gui, GUI_Overlay:New, +ToolWindow  +LastFound +AlwaysOnTop -Caption +hwndGUI_Overlay_hwnd
	WinGet, WinHND, ID, A
	Gui,Vol:+0x40000000 -0x80000000 +Owner%WinHND%
	Gui, Margin, -20, 8
	Gui, Font, s10 q0, Segoe UI
	Gui, Add, Text, w170 Center cWhite,Number of Meepos: %MEEPO_COUNT% a

	Gui, Color, 000000
	WinSet, Transparent, 200
	Gui, Show, Hide, Overlay

	WinMove, A_ScreenWidth - 170 - 8, 8
	Gui, GUI_Overlay:Show
Return

HideOverlay:
	SetTimer, HideOverlay, Off
	Gui, GUI_Overlay:Destroy
Return








; Separated because main meepo has no toggle
POOF__MAIN_MEEPO:
	Gosub, CAST__POOF
	Return

; Poofs (Or tries to puff) all other meepos and finally selects main meepo
; Should corrrectly include aghas and manta meepos
POOF__ALL_EXCEPT_MAIN_MEEPO:
	;Gosub, SELECT__PRIMARY_MEEPO
	; Not sure why it does not compute POOF_COUNT as integer properly without the function
	POOF__COUNT := MEEPO_COUNT - 1
	MsgBox, %POOF__COUNT%
	Loop %POOF__COUNT%
	{
		Gosub, TOGGLE__POOF
	}
	Gosub, TOGGLE__MEEPO
	; To keep it image / wrong number selection safe
	;Gosub, SELECT__PRIMARY_MEEPO
	Return

POOF__ALL_MEEPOS:
	Gosub, POOF__MAIN_MEEPO
	Gosub, POOF__ALL_EXCEPT_MAIN_MEEPO
	Return


SELECT__PRIMARY_MEEPO:
	Sleep, Round(100 * DELAY)
	Send, {%PRIMARY_MEEPO__KEY%}
	Sleep, Round(100 * DELAY)
	Return



TOGGLE__MEEPO:
	Sleep, Round(15 * DELAY)
	;Sleep, Round(15 * DELAY)
	Send {%NEXT_MEEPO__KEY%}
	SendInput, {%NEXT_MEEPO__KEY%}
	Return


CAST__POOF:
	Sleep, Round(10 * DELAY)
	Send %POOF__KEY%
	;SendInput, %POOF__KEY%
	Return

CAST__EARTHBIND:
	Send {%EARTHBIND__KEY%}
	Sleep, Round(10 * DELAY)
	Return


TOGGLE__POOF:
	Gosub, TOGGLE__MEEPO
	Gosub, CAST__POOF
	Return

TOGGLE__EARTHBIND:
	Gosub, TOGGLE__MEEPO
	Gosub, CAST__EARTHBIND
	Return


USE__ITEM(key){
	Send !{%key%}
	Sleep, Round(10 * DELAY)
}

TOGGLE__BLINK(){
	HAS__BLINK_DAGGER := !HAS__BLINK_DAGGER
}

USE__BLINK(){
	If(HAS__BLINK_DAGGER)
	{
		USE__ITEM( %BLINK_DAGGER__KEY% )
	}
}

TOGGLE__GUINSOO(){
	HAS__GUINSOO := !HAS__GUINSOO
}

USE__GUINSOO(){
	If(HAS__GUINSOO)
	{
		USE__ITEM( %GUINSOO__KEY% )
	}
}

TOGGLE__ACTIVE_ITEM_3(){
	HAS__ACTIVE_ITEM_3 := !HAS__ACTIVE_ITEM_3
}

USE__ACTIVE_ITEM_3(){
	If(HAS__ACTIVE_ITEM_3)
	{
		USE__ITEM( %ACTIVE_ITEM_3__KEY% )
	}
}









MEEPO_COUNT__INCREASE(){
	If(MEEPO_COUNT >= MAX__MEEPOS)
	{
		Return
	}
	MEEPO_COUNT := MEEPO_COUNT + 1
	MEEPO_COUNT := AddFunc(%MEEPO_COUNT%, 1)
	MsgBox, %MEEPO_COUNT%
}

MEEPO_COUNT__DECREASE(){
	If(MEEPO_COUNT <= MIN__MEEPOS)
	{
		Return
	}
	MEEPO_COUNT := MEEPO_COUNT - 1
	MsgBox, %MEEPO_COUNT%
	MsgBox, "Itshouldntbwhww"
}

ADD__AGHANIMS(){
	MsgBox, "Inside Add Aghanims"
	If (MAX__MEEPOS = LOWEST_MAX_POSSIBLE__MEEPOS Or MAX__MEEPOS = MAX_POSSIBLE__MEEPOS - 1)
	{
		MAX__MEEPOS := MAX__MEEPOS + 1
		MEEPO_COUNT__INCREASE()
		HAS__AGHANIM := True
	}
}

REMOVE__AGHANIMS(){
	If (MAX__MEEPOS = MAX_POSSIBLE__MEEPOS Or MAX__MEEPOS = MAX_POSSIBLE__MEEPOS - 2)
	{
		MAX__MEEPOS := MAX__MEEPOS - 1
		MEEPO_COUNT__DECREASE()
		HAS__AGHANIM := False
	}
}

TOGGLE__AGHANIM(){
	If (HAS__AGHANIM)
	{
		REMOVE__AGHANIMS()
	}
	Else
	{
		ADD__AGHANIMS()
	}
}



ADD__MANTA(){
	If (MAX__MEEPOS <= MAX_POSSIBLE__MEEPOS - 2)
	{
		MAX__MEEPOS := MAX__MEEPOS + 2
		MEEPO_COUNT__INCREASE()
		MEEPO_COUNT__INCREASE()
		HAS__MANTA := True
	}
}
REMOVE__MANTA(){
	; The +1 here is to account for possible aghas
	If (MAX__MEEPOS >= MAX_POSSIBLE__MEEPOS - 1)
	{
		MAX__MEEPOS := MAX__MEEPOS - 2
		MEEPO_COUNT__DECREASE()
		MEEPO_COUNT__DECREASE()
		HAS__AGHANIM := False
	}
}

TOGGLE__MANTA(){
	If (HAS__MANTA)
	{
		REMOVE__MANTA()
	}
	Else
	{
		ADD__MANTA()
	}
}





;TOGGLE__SUSPEND(){
;	Suspend, Permit
;	Suspend, Toggle
;}
;
;SUSPEND__SCRIPT(){
;	Suspend, On
;}
;
;UNSUSPEND__SCRIPT(){
;	Suspend, Permit
;	Suspend, Off
;	SCRIPT__TEMPORARILY_SUSPENDED := False
;}
;
;RELOAD__SCRIPT(){
;	Suspend, Permit
;	Reload
;}
;
;KILL__SCRIPT(){
;	Suspend, Permit
;	ExitApp, 0
;}
;

Subtract(var1, var2){
	Return var1 - var2
}
AddFunc(var1, var2){
	Return var1 + var2
}


;b::
;Gosub, Label1 
;MsgBox, The Label1 subroutine has returned (it is finished).
;return
;
;Label1:
;MsgBox, The Label1 subroutine is now running.
;return

;Fullscreen overlay
;https://autohotkey.com/boards/viewtopic.php?t=47776

;Dota scripts
;https://autohotkey.com/boards/viewtopic.php?t=43738