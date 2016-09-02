Class PatientWS.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="PatientWS.Production" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="PatientWS.BusinessOperation" Category="" ClassName="PatientWS.BusinessOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="HTTPPort">9980</Setting>
    <Setting Target="Adapter" Name="HTTPServer">localhost</Setting>
    <Setting Target="Adapter" Name="URL">/Patients</Setting>
  </Item>
</Production>
}

}
