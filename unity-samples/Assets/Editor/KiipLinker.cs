using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor.Callbacks;
using UnityEditor;
using UnityEditor.iOS.Xcode;
using System.IO;

public class KiipLinker{

	[PostProcessBuildAttribute (0)]
	public static void OnPostprocessBuild (BuildTarget buildTarget, string pathToBuiltProject)
	{

		// Stop processing if targe is NOT iOS
		if (buildTarget != BuildTarget.iOS)
			return; 

		// Initialize PbxProject
		var projectPath = pathToBuiltProject + "/Unity-iPhone.xcodeproj/project.pbxproj";
		PBXProject pbxProject = new PBXProject ();
		pbxProject.ReadFromFile (projectPath);
		string targetGuid = pbxProject.TargetGuidByName ("Unity-iPhone");

		// Adding REQUIRED framwrok
		pbxProject.AddFrameworkToProject(targetGuid, "CoreTelephony.framework", false);
		pbxProject.AddFrameworkToProject(targetGuid, "QuartzCore.framework", false);
		pbxProject.AddFrameworkToProject(targetGuid, "SystemConfiguration.framework", false);
		pbxProject.AddFrameworkToProject(targetGuid, "AdSupport.framework", false);
		pbxProject.AddFrameworkToProject(targetGuid, "Passkit.framework", false);
		pbxProject.AddFrameworkToProject(targetGuid, "MediaPlayer.framework", false);

		// Apply settings
		File.WriteAllText (projectPath, pbxProject.WriteToString ());

	}
}
