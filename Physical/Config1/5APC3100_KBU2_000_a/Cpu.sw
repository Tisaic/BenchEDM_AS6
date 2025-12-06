<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio FileVersion="4.9"?>
<SwConfiguration CpuAddress="" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="Sim" Source="Process.Sim.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="InputMan" Source="Process.InputMan.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Monitor" Source="Process.Monitor.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Seq_MASTER" Source="Process.Seq_MASTER.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="OutputMan" Source="Process.OutputMan.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2" />
  <TaskClass Name="Cyclic#3" />
  <TaskClass Name="Cyclic#4" />
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8">
    <Task Name="BuildVer" Source="BuildVersion.BuildVer.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="Services" Source="Services.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Vis" Source="Vis.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Dev" Source="Dev.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <DataObjects>
    <DataObject Name="MbRTU" Source="Libraries.MbRTU.dob" Memory="UserROM" Language="Simple" />
    <DataObject Name="McAcpSys" Source="" Memory="UserROM" Language="Binary" />
    <DataObject Name="datamod" Source="" Memory="UserROM" Language="Binary" />
  </DataObjects>
  <NcDataObjects>
    <NcDataObject Name="AcpParTabL" Source="Libraries.AcpParTabL.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="McDriveLog" Source="" Memory="UserROM" Language="Binary" />
  </NcDataObjects>
  <Binaries>
    <BinaryObject Name="udbdef" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="mvLoader" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCLang" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCData" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="FWRules" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ArSvcReg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="mvConfig" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="McAcpSim" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="McAcpDrv" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="McMechSys" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="mvDatApi" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="McProfGen" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="BRRole" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Role" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ashwac" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="UaCsConfig" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="TC" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="User" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="AlarmHist" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="AlarmCore" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="AlarmList" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_1" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="mCoWebSc" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Settings" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_2" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Hierarchy" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_3" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_4" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_6" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="asnxdb1" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Config_5" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="AlarmCat" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
  <ReActionTechnologyObjects>
    <ReActionTechnologyObject Name="StepDir" Source="StepDir.prg" Memory="UserROM" Language="ReAction" />
  </ReActionTechnologyObjects>
  <Libraries>
    <LibraryObject Name="TC_General" Source="Libraries.TC_General.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_Version" Source="Libraries.TC_Version.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_IO" Source="Libraries.TC_IO.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_Dir" Source="Libraries.TC_Dir.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_Convert" Source="Libraries.TC_Convert.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_ItemX" Source="Libraries.TC_ItemX.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_Array" Source="Libraries.TC_Array.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_SysErr" Source="Libraries.TC_SysErr.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_Eval" Source="Libraries.TC_Eval.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_Mon" Source="Libraries.TC_Mon.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_Recipe" Source="Libraries.TC_Recipe.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_Sim" Source="Libraries.TC_Sim.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_AlarmX" Source="Libraries.TC_AlarmX.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_RAND" Source="Libraries.TC_RAND.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="operator" Source="Libraries.operator.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="runtime" Source="Libraries.runtime.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsIecCon" Source="Libraries.AsIecCon.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="astime" Source="Libraries.astime.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="ArEventLog" Source="Libraries.ArEventLog.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="ArProject" Source="Libraries.ArProject.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsBrStr" Source="Libraries.AsBrStr.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="brsystem" Source="Libraries.brsystem.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="FileIO" Source="Libraries.FileIO.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsUSB" Source="Libraries.AsUSB.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="standard" Source="Libraries.standard.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="ArTextSys" Source="Libraries.ArTextSys.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="sys_lib" Source="Libraries.sys_lib.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MTTypes" Source="Libraries.MTTypes.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MTBasics" Source="Libraries.MTBasics.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MTFilter" Source="Libraries.MTFilter.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsSMTP" Source="Libraries.AsSMTP.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="ArCert" Source="Libraries.ArCert.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="ArSsl" Source="Libraries.ArSsl.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsIODiag" Source="Libraries.AsIODiag.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsTCP" Source="Libraries.AsTCP.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsXml" Source="Libraries.AsXml.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MpAlarmX" Source="Libraries.MpAlarmX.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpBase" Source="Libraries.MpBase.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpRecipe" Source="Libraries.MpRecipe.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="McBase" Source="Libraries.McBase.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MpAxis" Source="Libraries.MpAxis.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McAxis" Source="Libraries.McAxis.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McAcpAx" Source="Libraries.McAcpAx.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsZip" Source="Libraries.AsZip.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McAxGroup" Source="Libraries.McAxGroup.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="McPathGen" Source="Libraries.McPathGen.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="McProgInt" Source="Libraries.McProgInt.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="SfDomain" Source="Libraries.SfDomain.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpCnc" Source="Libraries.MpCnc.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="McPureVAx" Source="Libraries.McPureVAx.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsIORTI" Source="Libraries.AsIORTI.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="TC_Str" Source="Libraries.TC_Str.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="CoTrace" Source="Libraries.CoTrace.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="DRV_mbus" Source="Libraries.DRV_mbus.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="dvframe" Source="Libraries.dvframe.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="DataObj" Source="Libraries.DataObj.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="HA_Matrix" Source="Libraries.HA_Matrix.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_NGRC" Source="Libraries.TC_NGRC.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_Seq" Source="Libraries.TC_Seq.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="TC_JSON" Source="Libraries.TC_JSON.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="AsBrMath" Source="Libraries.AsBrMath.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="TC_FrSky" Source="Libraries.TC_FrSky.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="AsUDP" Source="Libraries.AsUDP.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="UaCoal" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="UaCoalPrv" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="powerlnk" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsEPL" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="SfDomDrv" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsIO" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsMem" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsIOAcc" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="ArUser" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpSfDomMgr" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="SfDomVis" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArProf" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>