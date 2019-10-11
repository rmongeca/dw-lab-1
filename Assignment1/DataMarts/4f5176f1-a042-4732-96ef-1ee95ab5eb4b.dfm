<?xml version="1.0" encoding="UTF-8"?>
<graphml xmlns="http://iconsulting.biz/dfm"><graph id="G" edgedefault="directed" toolversion="3.2.2.0" factSchemaId="4f5176f1-a042-4732-96ef-1ee95ab5eb4b" name="Logs" xmlns=""><node><data><Fact Name="Logs" Description="" Id="88bb6113-1adb-4591-b9c2-baef4f3b3eeb" X="550" Y="340" Width="143" Height="76"><Measures><Measure Name="log_count" Id="b646b0c2-6883-4e16-b632-f3bfb297385f"><Formula /></Measure><Measure Name="name" Id="76ae32e7-5db4-48ea-afd8-4a14d58d1772"><Formula /></Measure></Measures><GroupsOfMeasures /></Fact></data></node><node><data><Attribute Name="Planes" Description="" Id="2882c1cf-5f64-4186-a203-c03a647907fb" X="500" Y="370"><logicalModeling LogicalName="PLANES" /></Attribute></data></node><node><data><Attribute Name="model" Description="" Id="a12b4b6a-3d5a-4bd9-bc5e-77b4f9ef7f25" X="405" Y="370"><logicalModeling LogicalName="MODEL" /></Attribute></data></node><node><data><Attribute Name="manufacturer" Description="" Id="33541d57-79bb-4d48-b205-cc37d42cdb88" X="320" Y="370"><logicalModeling LogicalName="MANUFACTURER" /></Attribute></data></node><node><data><Attribute Name="Person" Description="" Id="859ecd5d-0905-4d6e-a64b-778547b5208c" X="625" Y="290" /></data></node><node><data><Attribute Name="airport" Description="" Id="bd20cb12-9289-401a-8598-a277d0ad49cd" X="580" Y="235" /></data></node><node><data><Attribute Name="personnel_type" Description="" Id="de5dd12f-b2ec-4ea0-aa5f-b653bba50f09" X="676" Y="235" /></data></node><node><data><Attribute Name="Dates" Description="" Id="0b7d6fd9-1be3-42b8-a750-ced4b7fbbc34" X="724" Y="371"><logicalModeling LogicalName="DATES" /></Attribute></data></node><node><data><Attribute Name="month" Description="" Id="79e654df-e210-4763-a1e3-d779ac1d0673" X="880" Y="370"><logicalModeling LogicalName="MONTH" /></Attribute></data></node><node><data><Attribute Name="year" Description="" Id="d47156a0-a308-477a-afaa-1ad28c415fa6" X="975" Y="370"><logicalModeling LogicalName="YEAR" /></Attribute></data></node><edge id="52867565-6b8c-4abd-ba56-8eb3e8423dee" source="88bb6113-1adb-4591-b9c2-baef4f3b3eeb" target="2882c1cf-5f64-4186-a203-c03a647907fb"><data><Arc /></data></edge><edge id="0d4c0b79-18e1-49e0-a6ca-76e8189eeadc" source="88bb6113-1adb-4591-b9c2-baef4f3b3eeb" target="859ecd5d-0905-4d6e-a64b-778547b5208c"><data><Arc /></data></edge><edge id="abec7102-7025-4530-83d2-8639cc8feab7" source="a12b4b6a-3d5a-4bd9-bc5e-77b4f9ef7f25" target="33541d57-79bb-4d48-b205-cc37d42cdb88"><data><Arc IndexOfSameNodesLink="1" /></data></edge><edge id="94124e1d-4a27-4001-aa2f-fa8822a11fa2" source="859ecd5d-0905-4d6e-a64b-778547b5208c" target="bd20cb12-9289-401a-8598-a277d0ad49cd"><data><Arc IndexOfSameNodesLink="1" /></data></edge><edge id="9311e5a2-01e8-4323-b874-301564857720" source="859ecd5d-0905-4d6e-a64b-778547b5208c" target="de5dd12f-b2ec-4ea0-aa5f-b653bba50f09"><data><Arc IndexOfSameNodesLink="1" /></data></edge><edge id="61c65d0e-cf64-41fd-8976-ba22c2b2865c" source="2882c1cf-5f64-4186-a203-c03a647907fb" target="a12b4b6a-3d5a-4bd9-bc5e-77b4f9ef7f25"><data><Arc IndexOfSameNodesLink="1" /></data></edge><edge id="c2614bbe-8669-4f22-9edc-b7e91bc082f0" source="79e654df-e210-4763-a1e3-d779ac1d0673" target="d47156a0-a308-477a-afaa-1ad28c415fa6"><data><Arc IndexOfSameNodesLink="1" /></data></edge><edge id="1457a08a-0b3c-4b41-82ae-bcec5330d672" source="88bb6113-1adb-4591-b9c2-baef4f3b3eeb" target="0b7d6fd9-1be3-42b8-a750-ced4b7fbbc34"><data><Arc /></data></edge><edge id="bd00143f-3096-457f-9113-b2e10cc7b6fe" source="0b7d6fd9-1be3-42b8-a750-ced4b7fbbc34" target="79e654df-e210-4763-a1e3-d779ac1d0673"><data><Arc IndexOfSameNodesLink="1" /></data></edge><hierarchy id="a03eb1eb-6ef5-4a5f-98e1-8bbfaf41d690" rootArcId="52867565-6b8c-4abd-ba56-8eb3e8423dee" name="Planes" description="" note="" /><hierarchy id="e91da3ef-8785-4f2e-9af6-d9f7da0fc4b7" rootArcId="0d4c0b79-18e1-49e0-a6ca-76e8189eeadc" name="Person" description="" note="" /><hierarchy id="2c9662c2-9526-4985-a8d4-1b4a2f70e031" rootArcId="1457a08a-0b3c-4b41-82ae-bcec5330d672" name="Dates" description="" note="" /></graph><additivityMatrix xmlns=""><item measureId="b646b0c2-6883-4e16-b632-f3bfb297385f" hierarchyId="a03eb1eb-6ef5-4a5f-98e1-8bbfaf41d690"><operator id="Sum" /></item><item measureId="b646b0c2-6883-4e16-b632-f3bfb297385f" hierarchyId="e91da3ef-8785-4f2e-9af6-d9f7da0fc4b7"><operator id="Sum" /></item><item measureId="b646b0c2-6883-4e16-b632-f3bfb297385f" hierarchyId="2c9662c2-9526-4985-a8d4-1b4a2f70e031"><operator id="Sum" /></item><item measureId="76ae32e7-5db4-48ea-afd8-4a14d58d1772" hierarchyId="a03eb1eb-6ef5-4a5f-98e1-8bbfaf41d690"><operator id="Sum" /></item><item measureId="76ae32e7-5db4-48ea-afd8-4a14d58d1772" hierarchyId="e91da3ef-8785-4f2e-9af6-d9f7da0fc4b7"><operator id="Sum" /></item><item measureId="76ae32e7-5db4-48ea-afd8-4a14d58d1772" hierarchyId="2c9662c2-9526-4985-a8d4-1b4a2f70e031"><operator id="Sum" /></item></additivityMatrix></graphml>