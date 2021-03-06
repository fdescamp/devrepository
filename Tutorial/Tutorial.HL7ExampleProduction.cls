Class Tutorial.HL7ExampleProduction Extends Ens.Production [ ProcedureBlock ]
{

XData ProductionDefinition
{
<Production Name="Tutorial.HL7ExampleProduction" LogGeneralTraceEvents="false">
  <Description>NewProduction</Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="TutorialHL7FileService" Category="" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" InactivityTimeout="0" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">TutorialHL7MessageRouter</Setting>
    <Setting Target="Host" Name="MessageSchemaCategory">2.3.1</Setting>
    <Setting Target="Adapter" Name="FilePath">C:\Tutorial\In</Setting>
    <Setting Target="Adapter" Name="FileSpec">ABC1.txt</Setting>
  </Item>
  <Item Name="TutorialHL7MessageRouter" Category="" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" InactivityTimeout="0" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">Tutorial.TutorialHL7MessageRouterRules</Setting>
  </Item>
  <Item Name="TutorialHL7FileOperation" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" InactivityTimeout="0" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Filename">ABC1Out.txt</Setting>
    <Setting Target="Adapter" Name="FilePath">C:\Tutorial\Out</Setting>
  </Item>
</Production>
}

}
