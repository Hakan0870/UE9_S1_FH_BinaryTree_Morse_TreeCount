PROGRAM TreeCount;

TYPE
    TreeNodePtr = ^TreeNode;
    TreeNode = RECORD
        left, right: TreeNodePtr;
        data: INTEGER;
    END;
    TreePtr = TreeNodePtr;



PROCEDURE InitTree(VAR t: TreePtr);
BEGIN
    t := NIL;
END;


PROCEDURE DisposeTree(t: TreePtr);
BEGIN
    IF t = NIL THEN
    ELSE BEGIN
        DisposeTree(t^.left);
        DisposeTree(t^.right);
        Dispose(t);
    END;
END;


PROCEDURE AddValue(VAR t: TreePtr; value: INTEGER);
VAR
    n: TreePtr;
BEGIN
    IF t = NIL THEN BEGIN
        New(n);
        n^.data := value;
        n^.left := NIL;
        n^.right := NIL;
        t := n;
    END ELSE IF value < n^.data THEN   
        AddValue(t^.left, value)
    ELSE
        AddValue(t^.right, value);
END;


PROCEDURE DisplayTree(t: TreePtr);
BEGIN
    IF t = NIL THEN
    ElSE BEGIN
        (* in-order*)
        DisplayTree(t^.left);
        Write(t^.data, ' ');
        DisplayTree(t^.right);
    END;
END;


FUNCTION CountNodesLessThan(t: TreePtr; x: INTEGER): INTEGER;
BEGIN
    IF t = NIL THEN
        CountNodesLessThan := 0
    ELSE IF x <= t^.data THEN
        CountNodesLessThan := CountNodesLessThan(t^.left, x)
    ELSE 
        CountNodesLessThan := CountNodesLessThan(t^.left, x) + CountNodesLessThan(t^.right, x) + 1
END;




VAR
    t: TreePtr;
BEGIN
    InitTree(t);

    DisplayTree(t); WriteLn;

    AddValue(t, 10);
    AddValue(t, 150);
    AddValue(t, 20);
    AddValue(t, 5);
    AddValue(t, 18);
    AddValue(t, 24);
    AddValue(t, 3);
    AddValue(t, 79);

    DisplayTree(t); WriteLn;
    WriteLn;
    WriteLn('Nodes less than value 151: ',CountNodesLessThan(t, 151));

    DisposeTree(t);
END.
