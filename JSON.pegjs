/** CONVERT JAVASCRIPT OBJECT IN JSON
· Input example:
    var coche = new Object();
    coche.marca = "Seat";
    coche.modelo = "Ibiza";
    coche.ruedas = 4;
    coche.cv = 90;
    coche.arrayPiezas = ["Motor", "Caja de cambios", 3];
**/

{
  var objectName;
}

json
 = dec:declaration st:statements+{
   return "{" + st + "}";
 }

declaration
= VAR id:ID EQUAL OBJECT SEMICOLON {objectName = id.trim();}

statements
= ob:ID DOT atr:ID EQUAL nom:STRING SEMICOLON{
  if(ob != objectName)
    return "ERROR! Object not declared."

  else
    return `"${atr.trim()}":${nom}`
}

/ ob:ID DOT atr:ID EQUAL num:NUMBER SEMICOLON{
  if(ob != objectName)
    return "ERROR! Object not declared."

  else
    return `"${atr.trim()}":${num}`
}

/ ob:ID DOT atr:ID EQUAL a:array {
  if(ob != objectName)
    return "ERROR! Object not declared."

  else
    return `"${atr.trim()}":${a}`
}

array
= LEFT_COR s:STRING st:array_final_st{
    return `[${s}` + st;
  }

/ LEFT_COR n:NUMBER st:array_final_st{
    return `[${n}` + st;
}

array_final_st
= COMMA n:NUMBER st:array_final_st+{
    return `, ${n}` + st;
}

/ COMMA s:STRING st:array_final_st+{
    return `, ${s}` + st;
}

/ RIGHT_COR SEMICOLON{
    return `]`;
}

_ = $([ \t\r\n]*)
VAR = $(_"var"_)
STRING = $(_'"'[A-Za-z ]+'"'_)
NUMBER = $(_[0-9]+_)
ID = $(_[A-Za-z]+_)
EQUAL = $(_"="_)
SEMICOLON = $(_";"_)
DOT = $(_"."_)
COMMA = $(_","_)
LEFT_COR = $(_"["_)
RIGHT_COR = $(_"]"_)
OBJECT = $(_"new Object\(\)"_)
