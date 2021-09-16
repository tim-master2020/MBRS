package myplugin;

import java.io.File;

import javax.swing.JOptionPane;

import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;


import com.nomagic.actions.NMAction;
import com.nomagic.magicdraw.actions.ActionsConfiguratorsManager;

/** MagicDraw plugin that performes code generation */
public class MyPlugin extends com.nomagic.magicdraw.plugins.Plugin {
	
	String pluginDir = null; 
	
	public void init() {
		JOptionPane.showMessageDialog( null, "My Plugin init");
		
		pluginDir = getDescriptor().getPluginDirectory().getPath();
		
		// Creating submenu in the MagicDraw main menu 	
		ActionsConfiguratorsManager manager = ActionsConfiguratorsManager.getInstance();		
		manager.addMainMenuConfigurator(new MainMenuConfigurator(getSubmenuActions()));
		
		/** @Todo: load project options (@see myplugin.generator.options.ProjectOptions) from 
		 * ProjectOptions.xml and take ejb generator options */
		
		//for test purpose only:
		generateOptions("ejbclass", "{0}.java", "src.main.java.com.example.demo.generated.models", "EJBGenerator");
		generateOptions("repositoryBase", "{0}BaseRepository.java", "src.main.java.com.example.demo.user.repositories", "EJBRepositoryGenerator");
		generateOptions("repository", "{0}Repository.java", "src.main.java.com.example.demo.generated.repositories", "EJBBaseRepositoryGenerator");
		generateOptions("controllerBase", "{0}ControllerBase.java", "demo.src.main.java.com.example.demo.user.controllers", "EJBControllerGenerator");
		generateOptions("controller", "{0}Controller.java", "src.main.java.com.example.demo.generated.controllers", "EJBBaseControllerGenerator");
		generateOptions("serviceBase", "{0}BaseService.java", "src.main.java.com.example.demo.user.services", "EJBServiceGenerator");
		generateOptions("service", "{0}Service.java", "src.main.java.com.example.demo.generated.services", "EJBBaseServiceGenerator");
		generateOptions("iserviceBase", "I{0}BaseService.java", "src.main.java.com.example.demo.user.interfaces", "EJBInterfaceGenerator");
		generateOptions("iservice", "I{0}Service.java", "src.main.java.com.example.demo.generated.interfaces", "EJBBaseInterfaceGenerator");
		generateOptions("page", "{0}Page.js", "demo.front", "EJBBasePageGenerator");
		generateOptions("App", "App.js", "demo.front", "EJBBaseAppGenerator");
		generateOptions("Index", "index.js", "demo.front", "EJBBaseIndexGenerator");
		generateOptions("table", "{0}Table.js", "demo.front", "EJBBaseTablesGenerator");
		generateOptions("edit", "Edit{0}.js", "demo.front", "EJBBaseEditGenerator");
		generateOptions("add", "Add{0}.js", "demo.front", "EJBBaseAddGenerator");
		//generateOptions("dto", "{0}DTO.java", "demo.src.main.java.com.example.demo.generated.dto", "EJBDTOGenerator");
		generateOptions("dto", "{0}DTO.java", "src.main.java.com.example.demo.generated.dto", "EJBDTOGenerator");
	}

	private void generateOptions(String templateName, String outputFilename, String filePackage, String k) {

		GeneratorOptions ejbOptions = new GeneratorOptions("c:/temp/demo/backend", templateName, "templates", outputFilename, true, filePackage);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put(k, ejbOptions);
		ejbOptions.setTemplateDir(pluginDir + File.separator + ejbOptions.getTemplateDir()); //apsolutna putanja
	}

	private NMAction[] getSubmenuActions()
	{
	   return new NMAction[]{
			new GenerateAction("Generate"),
	   };
	}
	
	public boolean close() {
		return true;
	}
	
	public boolean isSupported() {				
		return true;
	}
}


