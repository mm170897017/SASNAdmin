


LI-START
LI-END
!
!
!
!OAM (IPCLI) configuration
!
ManagedElement=1
  no SasnFunction=1
  SasnFunction=1
   Radius=1
    RadiusClient=10.205.4.7
     clientSecret="mysecret"
     radiusClientSignalingMode="INTERCEPTOR"
    up
    RadiusClient=10.205.4.8
     clientSecret="mysecret"
     radiusClientSignalingMode="INTERCEPTOR"
    up
    RadiusClient=10.205.4.9
     clientSecret="mysecret"
     radiusClientSignalingMode="INTERCEPTOR"
    up
    RadiusClient=10.205.4.10
     clientSecret="mysecret"
     radiusClientSignalingMode="INTERCEPTOR"
    up
    RadiusClient=10.205.4.11
     clientSecret="mysecret"
     radiusClientSignalingMode="INTERCEPTOR"
    up
    radiusServerIpAddress=10.229.190.13
    radiusServerIpAddress=192.168.211.65
    radiusServerIpAddress=10.229.190.14
    radiusServerIpAddress=10.229.190.15
    radiusServerIpAddress=10.229.190.16
    RadiusBehavior=1
    radiusInterimBehavior=ACCEPT_ACCOUNTING_INTERIM
    up
   up



 EricssonSupport="1"
  
  text="partition1:"
  text="ns module set scm logging 8"
  text="partition0:"
  text="ns module set diamtr-RXSRV1 logging 8"
  up
 Classification=1
  ContentTypeDefinition=1
   ContentType="100"
    contentTypeLabel="http"
    effectiveTime=0
    instancedSiblingOn=TRUE
    PatternMapping="1"
     patternFkId="1"
     typeOfPattern="BROWSING"
     up
    up
   ContentType="200"
    contentTypeLabel="http"
    effectiveTime=0
    instancedSiblingOn=TRUE
    PatternMapping="1"
     patternFkId="1"
     typeOfPattern="ICMP"
     up
    up
   ContentType="0"
    contentTypeLabel="default-all"
    instancedSiblingOn=TRUE
    PatternMapping="1"
     patternFkId="1"
     typeOfPattern="DEFAULT"
     up
    up
   up
  DefaultPatternSet=1
   DefaultPattern=1
    up
   up
  HttpPatternSet=1
   BrowsingPattern="1"
    aocControlOn=FALSE
    instancesOn=FALSE
    protocol="HTTP"
    Url="1"
     exactUrlOn=FALSE
     url="http://www.google.com"
     up
    up
   up
  IcmpPatternSet=1
   IcmpPattern="1"
    version=4
    up
   up
  ServiceSet="1"
   ContentTypeMapping="1"
    contentTypeFkId="100"
    up
   ContentTypeMapping="2"
    contentTypeFkId="200"
    up
   ContentTypeMapping="3"
    contentTypeFkId="0"
    up
   up
  up
 Server=1
  ControlServerRx="RXSRV1"
   primaryIpAddress="3.3.3.100"
   primaryPort="3890"
   realm="ericsson.com"
   secondaryPort="3890"
   txTimeout=100000000
   sendDestinationHostInitialOn =  FALSE
   originStateIdHandlingOn = FALSE
   up
  ControlServerRx="RXSRV2"
   primaryIpAddress="3.3.3.101"
   primaryPort="3868"
   realm="ericsson.com"
   secondaryPort="3868"
   txTimeout=10
   originStateIdHandlingOn = FALSE
   up
  up
 Rx=1
  RxContentTypeConfiguration="1"
   applicationId="AF_http"
   mediaComponentId="NONE"
   up
  RxContentTypeConfiguration="2"
   applicationId="AF_icmp"
   mediaComponentId="NONE"
   up
  RxProfile="rxpro1"
   RxProfileControlServer="RXSRV1"
    contentTypeRangeFkId="100"
    up
   up
  RxProfile="rxpro2"
   RxProfileControlServer="RXSRV2"
    contentTypeRangeFkId="200"
    up
   up
  up
 Policy=1
  PolicyDefinition=1
   PolicyCondition="1"
    conditionAttribute="RADIUS_FRAMED_ADDRESS"
    conditionOperator="IS"
    conditionValue="10.220.0.0/24"
    conditionValueCaseSensitiveOn=FALSE
    up
   PolicyCondition="2"
    conditionAttribute="RADIUS_FRAMED_ADDRESS"
    conditionOperator="IS"
    conditionValue="10.220.1.1"
    conditionValueCaseSensitiveOn=FALSE
    up
   PolicyRule="1"
    conditionRangeFkId="1"
    up
   PolicyRule="2"
    conditionRangeFkId="2"
    up
   PolicyRuleSet="100"
    ruleRangeFkId="1"
    up
   PolicyRuleSet="200"
    ruleRangeFkId="2"
    up
   up
  PolicyRuleSpace="rs"
   redirectConstraintsOneTimeOn=FALSE
   retransmitedPacketsReportOn=TRUE
   PolicyFeatureProfileSelector="rx"
    PolicyProfileSelector="1"
     policyRuleSetFkId="100"
     profileFkId="rxpro1"
     up
    up
   PolicyFeatureProfileSelector="rx"
    PolicyProfileSelector="2"
     policyRuleSetFkId="200"
     profileFkId="rxpro2"
     up
    up
   up
  PolicyServiceEnforcement="1"
   PolicyRxEnforcement="1"
    rxContentTypeConfigurationFkId="1"
    rxContentTypeRangeFkId="100"
    up
   PolicyRxEnforcement="2"
    rxContentTypeConfigurationFkId="2"
    rxContentTypeRangeFkId="200"
    up
   up
  PolicyUserPackage="1"
   PolicyProfileSelector="1"
    policyRuleSetFkId="100"
    profileFkId="TEST"
    up
   PolicyProfileSelector="2"
    policyRuleSetFkId="200"
    profileFkId="TEST"
    up
   PolicyUserProfile="TEST"
    ruleSpaceFkId="rs"
    up
   up
  up
 up
up

end
exit
!
!
