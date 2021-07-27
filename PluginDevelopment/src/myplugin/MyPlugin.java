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
		generateOptions("ejbclass", "{0}.java", "demo.src.main.java.com.example.demo.generated.models", "EJBGenerator");
		generateOptions("repositoryBase", "{0}BaseRepository.java", "demo.src.main.java.com.example.demo.user.repositories", "EJBRepositoryGenerator");
		generateOptions("ejbclass", "{0}Repository.java", "demo.src.main.java.com.example.demo.generated.repositories", "EJBBaseRepositoryGenerator");
	}

	private void generateOptions(String templateName, String outputFilename, String filePackage, String k) {

		GeneratorOptions ejbOptions = new GeneratorOptions("c:/temp", templateName, "templates", outputFilename, true, filePackage);
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


