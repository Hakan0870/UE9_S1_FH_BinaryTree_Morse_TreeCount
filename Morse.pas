PROGRAM Morse;

TYPE
    TreeNodePtr = ^TreeNode;
    TreeNode = RECORD
        left, right: TreeNodePtr;
        ch : CHAR;
        code: STRING;
    END;
    Tree = TreeNodePtr;


PROCEDURE InitTree(VAR t: Tree);
BEGIN
    t := NIL;
END;


PROCEDURE DisposeTree(t: Tree);
BEGIN
    IF t = NIL THEN
    ELSE BEGIN
        DisposeTree(t^.left);
        DisposeTree(t^.right);
        Dispose(t);
    END;
END;


PROCEDURE InsertEmptyNode(VAR t: Tree);
VAR
    newNode: TreeNodePtr;
BEGIN
    IF t = NIL THEN BEGIN
        New(newNode);
        newNode^.left := NIL;
        newNode^.right := NIL;
        t := newNode;
    END;
END;


PROCEDURE InsertMorseCode(VAR t: Tree; ch: CHAR; code: STRING);
VAR
    newNode: Tree;
BEGIN
    IF t = NIL THEN BEGIN
        New(newNode);
        newNode^.left := NIL;
        newNode^.right := NIL;
        newNode^.ch := ch;
        t := newNode;
    END ELSE IF code[1] = '.' THEN
        InsertMorseCode(t^.left, ch, Copy(code, 2, length(code)))
    ELSE
        InsertMorseCode(t^.right, ch, Copy(code, 2, length(code)));
END;

(*   ALTERNATIVE
PROCEDURE InsertMorseCode(VAR tree: MorseTreePtr; ch: CHAR; code: STRING);
VAR
    n: TreeNodePtr;
BEGIN
    IF tree = NIL THEN BEGIN
        New(n);
        n^.value := ch;
        n^.left := NIL;
        n^.right := NIL;
        tree := n;
    END
    ELSE IF code[1] = left THEN
        InsertMorseCode(tree^.left, ch, RightStr(code, Length(code) - 1))
    ELSE IF code[1] = right THEN
        InsertMorseCode(tree^.right, ch, RightStr(code, Length(code) - 1))
    ELSE // Illegal code sign
END;
*)



PROCEDURE DisplayTree(t: Tree);
BEGIN
    IF t = NIL THEN
    ElSE BEGIN
        (* in-order*)
        DisplayTree(t^.left);
        Write(t^.ch, ' ');
        DisplayTree(t^.right);
    END;
END;


FUNCTION Lookup(t: Tree; code: STRING): CHAR;
VAR
    n: Tree;
    i: INTEGER;
BEGIN
    n := t;
    FOR i := 1 TO length(code) DO BEGIN
        IF (code[i] = '.') AND (n^.left <> NIL) THEN
            n := n^.left
        ELSE IF (code[i] = '-') AND (n^.right <> NIL) THEN
            n := n^.right;
    END;
    Lookup := n^.ch;
END;

(*  ALTERNATIVE
FUNCTION Lookup(tree: MorseTreePtr; code: STRING): CHAR;
BEGIN
    IF tree = NIL THEN // Illegal code
        Lookup := ' '
    ELSE IF Length(code) = 0 THEN
        Lookup := tree^.value
    ELSE IF code[1] = left THEN
        Lookup := Lookup(tree^.left, RightStr(code, Length(code) - 1))
    ELSE IF code[1] = right THEN
        Lookup := Lookup(tree^.right, RightStr(code, Length(code) - 1))
    ELSE // Illegal code sign
        Lookup := ' ';
END;
*)

PROCEDURE TranslateCode(VAR t: Tree; code: STRING);
VAR
    x, y, i: INTEGER;
BEGIN
x := 1;
y := 0;

    FOR i := 1 TO length(code) DO BEGIN
        IF (code[i] = '.') OR (code[i] = '-') THEN
            y := y + 1
        ELSE IF (code[i] = ' ') THEN BEGIN
            Write(Lookup(t, Copy(code, x, y)));
            x := i + 1;
            y := 0;
        END ELSE IF (code[i] = ';') THEN BEGIN
            Write(Lookup(t, Copy(code, x, y)), ' ');
            x := i + 1;
            y := 0;
        END ELSE BEGIN
            WriteLn('Wrong Input: ');
        END
    END;
    WriteLn;
    WriteLn;
END;


(*  ALTERNATIVE
FUNCTION DecodeMessage(tree: MorseTreePtr; message: STRING): STRING;
VAR
    i: INTEGER;
    code: STRING;
    decodedMessage: STRING;
BEGIN
    code := '';
    decodedMessage := '';
    FOR i := 1 TO Length(message) DO BEGIN
        IF message[i] = endOfWord THEN BEGIN
            decodedMessage := decodedMessage + Lookup(tree, code) + ' ';
            code := '';
        END ELSE IF message[i] = endOfChar THEN BEGIN
            decodedMessage := decodedMessage + Lookup(tree, code);
            code := '';
        END ELSE
            code := code + message[i];
    END;
    DecodeMessage := decodedMessage + Lookup(tree, code);
END;
*)



VAR
    t: Tree;
BEGIN
    InitTree(t);
    InsertEmptyNode(t);

    InsertMorseCode(t, 'E', '.');
    InsertMorseCode(t, 'I', '..');
    InsertMorseCode(t, 'A', '.-');
    InsertMorseCode(t, 'S', '...');
    InsertMorseCode(t, 'U', '..-');
    InsertMorseCode(t, 'H', '....');
    InsertMorseCode(t, 'V', '...-');
    InsertMorseCode(t, 'R', '.-.');
    InsertMorseCode(t, 'L', '.-..');

    InsertMorseCode(t, 'W', '.--');
    InsertMorseCode(t, 'P', '.--.');
    InsertMorseCode(t, 'J', '.---');
    InsertMorseCode(t, 'T', '-');
    InsertMorseCode(t, 'N', '-.');
    InsertMorseCode(t, 'D', '-..');
    InsertMorseCode(t, 'K', '-.-');
    InsertMorseCode(t, 'X', '-..-');
    InsertMorseCode(t, 'B', '-...');
    InsertMorseCode(t, 'C', '-.-.');
    InsertMorseCode(t, 'M', '--');
    InsertMorseCode(t, 'G', '--.');
    InsertMorseCode(t, 'Z', '--..');
    InsertMorseCode(t, 'Q', '--.-');
    InsertMorseCode(t, 'O', '---');
    InsertMorseCode(t, 'F', '..-.');
    InsertMorseCode(t, 'Y', '-.--');

    WriteLn(Lookup(t, '.-'));
    WriteLn(Lookup(t, '-...'));
    WriteLn(Lookup(t, '-.-.'));
    WriteLn(Lookup(t, '-..'));
    WriteLn(Lookup(t, '.'));
    WriteLn(Lookup(t, '..-.'));
    WriteLn(Lookup(t, '--.'));
    WriteLn(Lookup(t, '....'));
    WriteLn(Lookup(t, '..'));
    WriteLn(Lookup(t, '.---'));
    WriteLn(Lookup(t, '-.-'));
    WriteLn(Lookup(t, '.-..'));
    WriteLn(Lookup(t, '--'));
    WriteLn(Lookup(t, '-.'));
    WriteLn(Lookup(t, '---'));
    WriteLn(Lookup(t, '.--.'));
    WriteLn(Lookup(t, '--.-'));
    WriteLn(Lookup(t, '.-.'));
    WriteLn(Lookup(t, '...'));
    WriteLn(Lookup(t, '-'));
    WriteLn(Lookup(t, '..-'));
    WriteLn(Lookup(t, '...-'));
    WriteLn(Lookup(t, '.--'));
    WriteLn(Lookup(t, '-..-'));
    WriteLn(Lookup(t, '-.--'));
    WriteLn(Lookup(t, '--..'));
    WriteLn;

    TranslateCode(t, '... .;.... .- --. . -. -... . .-. --. ');

    TranslateCode(t, '.... .- .-.. .-.. ---;.... .- -.- .- -. ');

    TranslateCode(t, '..d. .;.... .- --. . -. -... . .-. --. ');


    DisposeTree(t);
END.