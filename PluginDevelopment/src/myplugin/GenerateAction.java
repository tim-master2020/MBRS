package myplugin;

import java.awt.event.ActionEvent;
import java.io.*;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

import com.nomagic.magicdraw.actions.MDAction;
import com.nomagic.magicdraw.core.Application;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Package;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import myplugin.analyzer.AnalyzeException;
import myplugin.analyzer.ModelAnalyzer;
import myplugin.generator.EJBGenerator;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;
import myplugin.helpers.GeneratorMultipleHandler;
import myplugin.helpers.TreeCopyFileVisitor;

/** Action that activate code generation */
@SuppressWarnings("serial")
class GenerateAction extends MDAction{
	
	
	public GenerateAction(String name) {			
		super("", name, null, null);		
	}

	public void actionPerformed(ActionEvent evt) {
		
		if (Application.getInstance().getProject() == null) return;
		Package root = Application.getInstance().getProject().getModel();
		
		if (root == null) return;

		try {
			Path path = Paths.get("C:\\Users\\minam\\Desktop\\MBRS\\PluginDevelopment\\demo");
			String fromDirectory = path.toAbsolutePath().toString().replace('\\', '/');
			String toDirectory = "c:/temp/demo/backend";
			copyDirectoryFileVisitor(fromDirectory, toDirectory);

			Path pathFront = Paths.get("C:\\Users\\minam\\Desktop\\MBRS\\PluginDevelopment\\front");
			String fromDirectoryFront = pathFront.toAbsolutePath().toString().replace('\\', '/');
			String toToDirectoryFront = "c:/temp/front";
			copyDirectoryFileVisitor(fromDirectoryFront, toToDirectoryFront);

			for (GeneratorOptions generatorOptions : ProjectOptions.getProjectOptions().getGeneratorOptions().values()) {
				//if(generatorOptions.getTemplateName() == "page" || generatorOptions.getTemplateName() == "edit") {
					//GeneratorMultipleHandler generator = new GeneratorMultipleHandler(generatorOptions);
					//ModelAnalyzer analyzer = new ModelAnalyzer(root, generatorOptions.getFilePackage());
					//analyzer.prepareModel();

					//generator.generate();
				//}
				EJBGenerator generator = new EJBGenerator(generatorOptions);
				ModelAnalyzer analyzer = new ModelAnalyzer(root, generatorOptions.getFilePackage());

				analyzer.prepareModel();
				generator.generate();
			}

			/**  @ToDo: Also call other generators */ 
			JOptionPane.showMessageDialog(null, "Code is successfully generated!");
			exportToXml();
		} catch (AnalyzeException | IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		} 			
	}
	
	private void exportToXml() {
		if (JOptionPane.showConfirmDialog(null, "Do you want to save FM Model?") == 
			JOptionPane.OK_OPTION)
		{	
			JFileChooser jfc = new JFileChooser();
			if (jfc.showSaveDialog(null) == JFileChooser.APPROVE_OPTION) {
				String fileName = jfc.getSelectedFile().getAbsolutePath();
			
				XStream xstream = new XStream(new DomDriver());
				BufferedWriter out;		
				try {
					out = new BufferedWriter(new OutputStreamWriter(
							new FileOutputStream(fileName), "UTF8"));					
					xstream.toXML(FMModel.getInstance().getClasses(), out);
					xstream.toXML(FMModel.getInstance().getEnumerations(), out);
					
				} catch (UnsupportedEncodingException e) {
					JOptionPane.showMessageDialog(null, e.getMessage());				
				} catch (FileNotFoundException e) {
					JOptionPane.showMessageDialog(null, e.getMessage());				
				}		             
			}
		}	
	}

	public static void copyDirectoryFileVisitor(String source, String target)
			throws IOException {

		TreeCopyFileVisitor fileVisitor = new TreeCopyFileVisitor(source, target);
		Files.walkFileTree(Paths.get(source), fileVisitor);
	}

}