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
		generateOptions("repositoryBase", "{0}BaseRepository.java", "src.main.java.com.example.demo.generated.repositories", "EJBRepositoryGenerator");
		generateOptions("repository", "{0}Repository.java", "src.main.java.com.example.demo.user.repositories", "EJBBaseRepositoryGenerator");
		generateOptions("controllerBase", "{0}BaseController.java", "src.main.java.com.example.demo.generated.controllers", "EJBControllerGenerator");
		generateOptions("controller", "{0}Controller.java", "src.main.java.com.example.demo.user.controllers", "EJBBaseControllerGenerator");
		generateOptions("serviceBase", "{0}BaseService.java", "src.main.java.com.example.demo.generated.services", "EJBServiceGenerator");
		generateOptions("service", "{0}Service.java", "src.main.java.com.example.demo.user.services", "EJBBaseServiceGenerator");
		generateOptions("interfaceBase", "{0}BaseInterface.java", "src.main.java.com.example.demo.generated.interfaces", "EJBInterfaceGenerator");
		generateOptions("interface", "{0}Interface.java", "src.main.java.com.example.demo.user.interfaces", "EJBBaseInterfaceGenerator");
		generateOptionsFront("page", "{0}Page.js", "front.src", "EJBBasePageGenerator");
		generateOptionsFront("App", "App.js", "front.src", "EJBBaseAppGenerator");
		generateOptionsFront("table", "{0}Table.js", "front.src", "EJBBaseTablesGenerator");
		generateOptionsFront("edit", "Edit{0}.js", "front.src", "EJBBaseEditGenerator");
		generateOptionsFront("add", "Add{0}.js", "front.src", "EJBBaseAddGenerator");
		//generateOptions("dto", "{0}DTO.java", "demo.src.main.java.com.example.demo.generated.dto", "EJBDTOGenerator");
		generateOptions("dto", "{0}DTO.java", "src.main.java.com.example.demo.generated.dto", "EJBDTOGenerator");
		generateOptions("enumeration", "{0}.java", "src.main.java.com.example.demo.generated.enumeration", "EnumGenerator");
	}

	private void generateOptions(String templateName, String outputFilename, String filePackage, String k) {

		GeneratorOptions ejbOptions = new GeneratorOptions("c:/temp/demo/backend", templateName, "templates", outputFilename, true, filePackage);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put(k, ejbOptions);
		ejbOptions.setTemplateDir(pluginDir + File.separator + ejbOptions.getTemplateDir()); //apsolutna putanja
	}

	private void generateOptionsFront(String templateName, String outputFilename, String filePackage, String k) {

		GeneratorOptions ejbOptions = new GeneratorOptions("c:/temp/demo", templateName, "templates", outputFilename, true, filePackage);
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


