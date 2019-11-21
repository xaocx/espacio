
float  EchoPin =  6;
float TriggerPin  = 5;
float LedPinVerde =  11;
int val1;

int distancia;
long tiempo;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(EchoPin, INPUT);
  pinMode(TriggerPin, OUTPUT);
  pinMode(LedPinVerde, OUTPUT);
}

void loop() {

  // put your main code here, to run repeatedly:
  digitalWrite(TriggerPin, HIGH);
  delayMicroseconds(100);
  digitalWrite(TriggerPin, LOW);

  tiempo = ( pulseIn(EchoPin, HIGH) / 2);
  distancia = (tiempo * 0.0343);


  val1 = analogRead(0);
  val1 = map(val1, 0, 1023, 0, 100);

  //  Serial.write(val1);

  Serial.write(distancia);


  if (distancia <= 40) {
    // tone(buzz, 100,1000);
    digitalWrite(LedPinVerde, HIGH);
  } else {
    digitalWrite(LedPinVerde, LOW);
  }
  //delay(100);
}
