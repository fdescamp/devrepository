Class Tutorial.ExampleProduction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Tutorial.ExampleProduction" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description>NewProduction</Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Setting Target="Production" Name="ShutdownTimeout">120</Setting>
  <Setting Target="Production" Name="UpdateTimeout">10</Setting>
  <Item Name="Tutorial.ExampleOperation" Category="" ClassName="Tutorial.ExampleOperation" PoolSize="1" Enabled="true" Foreground="false" InactivityTimeout="0" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
