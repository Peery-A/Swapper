#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

 
#Persistent

CoordMode, Mouse, Screen
SetBatchLines, -1
SetMouseDelay, 0
SetTitleMatchMode, 3
SetWinDelay, -1
Box_Init("00FF00")
Inventory_Width := 200
Inventory_Height := 270

;from original
;SysGet, Window_Border, 32, 33

WinGet, RuneScape_ID, ID, RuneLite - Uglyyo93
If (RuneScape_ID == "")
   ExitApp
WinGet, RuneScape_PID, PID, % "ahk_id " RuneScape_ID
Process, Exist, RuneLite.exe
If (ErrorLevel == 0 || (RuneScape_PID != ErrorLevel))
   ExitApp
SetTimer, Locate_Inventory, 0
Return

Locate_Inventory:
IfWinNotActive, % "ahk_id " RuneScape_ID
{
   Box_Hide()
   Return
}
WingetPos, RuneScape_X, RuneScape_Y, RuneScape_Width, RuneScape_Height, % "ahk_id " RuneScape_ID


;new comment

;from original
;If(RuneScape_Width < 775 || RuneScape_Height-Window_Border*2 < 566)
;{
  ; Box_Hide()
  ; Return
;}

Inventory_X := RuneScape_X + 1087
Inventory_Y := RuneScape_Y + 367
Box_Draw(Inventory_X, Inventory_Y, 285, 395)
Return

space::
IfWinNotActive, % "ahk_id " RuneScape_ID
   Return
SetTimer, Locate_Inventory, Off
Item_Numbers = 1|2|3|5|6 ;CHANGE THIS TO DESIRED
WingetPos, RuneScape_X, RuneScape_Y, RuneScape_Width, RuneScape_Height, % "ahk_id " RuneScape_ID
MouseGetPos, Mouse_X, Mouse_Y
Inventory_X := 1087
Inventory_Y := 367
First_Item_X := Inventory_X + RuneScape_X + 45
First_Item_Y := Inventory_Y + RuneScape_Y + 37
StringSplit, Item_Numbers, Item_Numbers, |
Loop, % Item_Numbers0
{
    Item_X := First_Item_X+Mod(Item_Numbers%A_Index%-1, 4)*66
    Item_Y := First_Item_Y+Div(Item_Numbers%A_Index%-1, 4)*55
    MouseMove, % Item_X, % Item_Y
    RClick()
	RSleep(50,100)
}
MouseMove, % Mouse_X, % Mouse_Y
SetTimer, Locate_Inventory, 0
Return

Div(X, Y) {
    Return Floor(X/Y)    
}

Box_Init(C="FF0000") {
   Gui, 96: +ToolWindow -Caption +AlwaysOnTop +LastFound
   Gui, 96: Color, % C
   Gui, 97: +ToolWindow -Caption +AlwaysOnTop +LastFound
   Gui, 97: Color, % C
   Gui, 98: +ToolWindow -Caption +AlwaysOnTop +LastFound
   Gui, 98: Color, % C
   Gui, 99: +ToolWindow -Caption +AlwaysOnTop +LastFound
   Gui, 99: Color, % C
}

Box_Draw(X, Y, W, H, T="1", O="I") {
   If(W < 0)
      X += W, W *= -1
   If(H < 0)
      Y += H, H *= -1
   If(T >= 2)
   {
      If(O == "O")
         X -= T, Y -= T, W += T, H += T
      If(O == "C")
         X -= T / 2, Y -= T / 2
      If(O == "I")
         W -= T, H -= T
   }
   Gui, 96: Show, % "x" X " y" Y " w" W " h" T " NA", Horizontal 1
   Gui, 98: Show, % "x" X " y" Y + H " w" W " h" T " NA", Horizontal 2
   Gui, 97: Show, % "x" X " y" Y " w" T " h" H " NA", Vertical 1
   Gui, 99: Show, % "x" X + W " y" Y " w" T " h" H " NA", Vertical 2
}

Box_Hide() {
   Loop, 4
      Gui, % A_Index + 95 ":  Hide"
}

RSleep(Min, Max) ;pass Min and Max values in miliseconds
{
	Random, r, Min, Max
	Sleep, r
}

RClick()
{
	Random, r, 10, 50
	Send {LButton down}
	Sleep,r
	Send {LButton up}
}