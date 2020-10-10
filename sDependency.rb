require 'xcodeproj'

def priorityDependencesFunction(dependencies)
priorityDependences = ["pgMainModule", "JDBBusinessFoundationModule",
    "JDBReactModule", "JDBMobileConfigModule", "JDBFoundationModule",
    "JDBRouterModule", "pgNavigationModule", "JDBEECrashModule",
    "SFAspectsModule", "JDBFingerPrintModule", "JDBTFModule",
    "JDBMTAModule", "pgUserManagerModule", "JDBMTAServiceModule",
    "pgWebViewModule", "JDBAPMModule", "JDBUniversalPushServiceModule",
    "JDBFireEyeModule", "JDBHttpDnsModule", "JDBShareUnitModule",
    "JDTQQSDKModule", "JDTWeChatSDKModule", "pgContainerModule", "pgHomePageModule"]

    deleteDependences = []
    for dependencyName in priorityDependences do
        for dependency in dependencies do
            if dependencyName == dependency.name
                deleteDependences << dependency
                break
            end
        end
    end

    dependencies.delete_if { |dependency|
        deleteDependences.include?(dependency)
    }

    for deleteDependency in deleteDependences.reverse do
        dependencies.unshift(deleteDependency)
    end
end


def sortDependecies()
    base_path = File.dirname(__FILE__)
    project_path = base_path + '/Pods/Pods.xcodeproj'
    pod_project = Xcodeproj::Project.open(project_path)
    pod_target = nil
    pod_project.targets.each_with_index do |target, index|
        if target.name  == "Pods-pgAppModule_Example"
            pod_target = target
        end
    end
    priorityDependencesFunction(pod_target.dependencies)
    pod_project.save
end

sortDependecies()
