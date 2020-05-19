unit uQuestion;

interface

type
  TQuestion = class(TObject)
  public
    FAnswer: string;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

constructor TQuestion.Create;
begin
// Calls the parent class' constructor
  inherited;
// Do whatever special initialization our class requires.
// For instance, let's answer all questions with "42" until
// they receive a different answer.
  FAnswer := '42';
end;

destructor TQuestion.Destroy;
begin
// Do whatever special destruction our class requires.
// In this case, we don't actually need to define a destructor,
// because there is nothing to destroy.
// Calls the parent's destructor. This should always be done in a destructor.
  inherited;
end;

end.
