DELAY := 1.00

QUAS_KEY := "q"
WEX_KEY := "w"
EXORT_KEY := "e"
INVOKE_KEY := "r"
FIRST_SPELL_KEY := "d"
SECOND_SPELL_KEY := "f"

ShouldResetAfterCasting := True
SCRIPT__TEMPORARILY_SUSPENDED := False

; Base functions
All__Quas(){
	Gosub, CastQuas
	Gosub, CastQuas
	Gosub, CastQuas
}

All__Wex(){
	Gosub, CastWex
	Gosub, CastWex
	Gosub, CastWex
}

All__Exort(){
	Gosub, CastExort
	Gosub, CastExort
	Gosub, CastExort
}

RESET__AfterCasting(){
	If (ShouldResetAfterCasting){
		All__Wex()
	}
}

; Quas spells
; Cold Snap
Cast__ColdSnap(){
	All__Quas()
	Gosub, CastInvoke
}
; Ghost Walk
Cast__Ghostwalk(){
	Gosub, CastQuas
	Gosub, CastQuas
	Gosub, CastWex
	Gosub, CastInvoke
}

;Ice wall
Cast__IceWall(){
	Gosub, CastQuas
	Gosub, CastQuas
	Gosub, CastExort
	Gosub, CastInvoke
}

; Wex spells
; EMP
Cast__EMP(){
	All__Wex()
	Gosub, CastInvoke
}
; Tornado
Cast__Tornado(){
	Gosub, CastWex
	Gosub, CastWex
	Gosub, CastQuas
	Gosub, CastInvoke
}
; Alacrity
Cast__Alacrity(){
	Gosub, CastWex
	Gosub, CastWex
	Gosub, CastExort
	Gosub, CastInvoke
}

; Exort spells
; Sun Strike
Cast__SunStrike(){
	All__Exort()
	Gosub, CastInvoke
}
; Forge Spirit
Cast__ForgeSpirit(){
	Gosub, CastExort
	Gosub, CastExort
	Gosub, CastQuas
	Gosub, CastInvoke
}
; Chaos Meteor
Cast__ChaosMeteor(){
	Gosub, CastExort
	Gosub, CastExort
	Gosub, CastWex
	Gosub, CastInvoke
}

; DefeaningBlast
Cast__DefeaningBlast(){
	Gosub, CastQuas
	Gosub, CastWex
	Gosub, CastExort
	Gosub, CastInvoke
}

; Key Binds

; 
Space & q::
	Cast__ColdSnap()
	All__Wex()
Return

; EMP
Space & w::
	Cast__EMP()
	All__Wex()
Return

; SunStrike
Space & e::
	Cast__SunStrike()
	All__Wex()
Return

; Tornado
Space & z::
	Cast__Tornado()
	All__Wex()
Return

; ChaosMeteor
Space & x::
	Cast__ChaosMeteor()
	All__Wex()
Return


; DeafeningBlast
Space & c::
	Cast__DefeaningBlast()
	All__Wex()
Return

; Cast__IceWall
Space & v::
	Cast__IceWall()
	All__Wex()
Return

; GhostWalk
Space & r::
	Cast__Ghostwalk()
	All__Wex()
Return

; Panic GhostWalk
Space & b::
	Cast__Ghostwalk()
	All__Wex()
	Gosub, CastFirstSpell
Return

; Alacrity
Space & t::
	Cast__Alacrity()
	All__Wex()
Return

; ForgeSpirit
; GhostWalk
Space & f::
	Cast__ForgeSpirit()
	All__Wex()
Return


; First and seconds spells
XButton1::
	Gosub, CastFirstSpell
Return

XButton2::
	Gosub, CastSecondSpell
Return

CastQuas:
	Send {%QUAS_KEY%}
	Sleep, Round(10 * DELAY)
Return

CastWex:
	Send {%WEX_KEY%}
	Sleep, Round(10 * DELAY)
Return

CastExort:
	Send {%EXORT_KEY%}
	Sleep, Round(10 * DELAY)
Return

CastFirstSpell:
	Sleep, Round(10 * DELAY)
	Send {%FIRST_SPELL_KEY%}
Return

CastSecondSpell:
	Sleep, Round(10 * DELAY)
	Send {%Second_SPELL_KEY%}
Return

CastInvoke:
	Send {%INVOKE_KEY%}
	Sleep, Round(10 * DELAY)
Return

; Suspend related stuff

TOGGLE__SUSPEND(){
	Suspend, Permit
	Suspend, Toggle
}

SUSPEND__SCRIPT(){
	Suspend, On
	SCRIPT__TEMPORARILY_SUSPENDED := True
}

UNSUSPEND__SCRIPT(){
	Suspend, Permit
	Suspend, Off
	SCRIPT__TEMPORARILY_SUSPENDED := False
}

RELOAD__SCRIPT(){
	Suspend, Permit
	Reload
}

KILL__SCRIPT(){
	Suspend, Permit
	ExitApp, 0
}

; This is to disable hotkey while typing in chat etc. And then reenable it after typing in chat
~Enter::
Suspend, Permit
	If (A_IsSuspended = 0)
	{
		SUSPEND__SCRIPT()
	}
	Else
	{
		UNSUSPEND__SCRIPT()
;		If (SCRIPT__TEMPORARILY_SUSPENDED)
;		{
;			UNSUSPEND__SCRIPT()
;		}
	}
Return

; This is to eenable the script if you choose to press escape in chat.
; Obviously there are still many ways to cancel the chat input without enabling
; Toggle the script if it does happen (Numpad5)
~Escape::
	Suspend, Permit
	If (A_IsSuspended = 0)
	{
		UNSUSPEND__SCRIPT()
	}
Return

Numpad5::
	Suspend, Permit
	TOGGLE__SUSPEND()
Return

; Reload scrip.
; Note that this would set all values to its default. (Includes meepo number would then be set to 1)
Numpad1::
	Suspend, Permit
	RELOAD__SCRIPT()
Return

Numpad2::
	Suspend, Permit
	UNSUSPEND__SCRIPT()
Return

; This should completely kills the running script. Script needs to be restarted from windows / shell.
Numpad9::
	KILL__SCRIPT()
Return

Pause::
	Suspend, Permit
	SUSPEND__SCRIPT()
Return