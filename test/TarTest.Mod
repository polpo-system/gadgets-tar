MODULE TarTest;  (** TarTest.Run: a small tar archive written and opened as a Tar document; needs the desktop's display *)

IMPORT Files, Objects, Display, Gadgets, Documents, Modules, Out := out;

VAR fails, checks: LONGINT;

PROCEDURE Check(what: ARRAY OF CHAR; ok: BOOLEAN);
BEGIN
  INC(checks);
  IF ~ok THEN INC(fails); Out.String("FAIL "); Out.String(what); Out.Ln END
END Check;

PROCEDURE Put(VAR b: ARRAY OF CHAR; pos: LONGINT; s: ARRAY OF CHAR);
VAR i: LONGINT;
BEGIN
  i := 0; WHILE s[i] # 0X DO b[pos + i] := s[i]; INC(i) END
END Put;

PROCEDURE Run*;
VAR f: Files.File; R: Files.Rider; b: ARRAY 512 OF CHAR; i: LONGINT; obj: Objects.Object; doc: Documents.Document;
BEGIN
  fails := 0; checks := 0;
  Check("Tar", Modules.ThisMod("Tar") # NIL);
  f := Files.New("zq_test.tar"); Files.Set(R, f, 0);
  i := 0; WHILE i < 512 DO b[i] := 0X; INC(i) END;
  Put(b, 0, "zq_a.txt"); Put(b, 124, "00000000005"); b[156] := "0"; Put(b, 257, "ustar");
  Files.WriteBytes(R, b, 512);
  i := 0; WHILE i < 512 DO b[i] := 0X; INC(i) END; Put(b, 0, "hello");
  Files.WriteBytes(R, b, 512);
  b[0] := 0X; b[1] := 0X; b[2] := 0X; b[3] := 0X; b[4] := 0X;
  Files.WriteBytes(R, b, 512); Files.WriteBytes(R, b, 512);
  Files.Register(f);
  obj := Gadgets.CreateObject("Tar.NewDoc");
  IF (obj # NIL) & (obj IS Documents.Document) THEN
    doc := obj(Documents.Document); doc.name := "zq_test.tar"; doc.Load(doc);
    Check("a Tar document of zq_test.tar", (doc.dsc # NIL) & (doc.dsc IS Display.Frame))
  ELSE Check("Tar.NewDoc", FALSE)
  END;
  Out.String("TarTest: "); Out.Int(checks, 0); Out.String(" checks, "); Out.Int(fails, 0); Out.String(" failed"); Out.Ln
END Run;

END TarTest.
