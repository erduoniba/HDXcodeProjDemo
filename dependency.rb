require 'xcodeproj'

def priorityDependencesFunction(dependencies)
    # 自定义依赖排序库（下面的排序优先级最高）
    priorityDependences = ["SDWebImage", "CocoaLumberjack",
        "HDBaseProject", "MJRefresh", "PINCache",
        "AFNetworking"]

    # 将工程所有依赖组件移除，并按照priorityDependences的顺序加入到deleteDependences中
    deleteDependences = []
    for dependencyName in priorityDependences do
        for dependency in dependencies do
            if dependencyName == dependency.name
                deleteDependences << dependency
                break
            end
        end
    end

    # dependencies删除deleteDependences的元素
    dependencies.delete_if { |dependency|
        deleteDependences.include?(dependency)
    }

    # 将deleteDependences插入到最前面
    for deleteDependency in deleteDependences.reverse do
        dependencies.unshift(deleteDependency)
    end
end


def sortDependecies()
    puts "sortDependecies start"
    # 当前路径
    base_path = File.dirname(__FILE__)
    project_path = base_path + '/Pods/Pods.xcodeproj'
    pod_project = Xcodeproj::Project.open(project_path)
    pod_target = nil
    pod_project.targets.each_with_index do |target, index|
        if target.name  == "Pods-HDXcodeProjDemo"
            pod_target = target
        end
    end
    priorityDependencesFunction(pod_target.dependencies)
    pod_project.save
    puts "sortDependecies end"
end

sortDependecies()
