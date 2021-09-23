package myplugin.analyzer;

import java.util.Iterator;
import java.util.List;

import myplugin.generator.fmmodel.CascadeType;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMEnumeration;
import myplugin.generator.fmmodel.FMLinkedProperty;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.fmmodel.FMPersistentProperty;
import myplugin.generator.fmmodel.FMProperty;
import myplugin.generator.fmmodel.FetchType;
import myplugin.helpers.PHelper;

import com.nomagic.uml2.ext.jmi.helpers.ModelHelper;
import com.nomagic.uml2.ext.jmi.helpers.StereotypesHelper;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Element;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.EnumerationLiteral;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Package;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Class;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Enumeration;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Property;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Type;
import com.nomagic.uml2.ext.magicdraw.mdprofiles.Stereotype;


/** Model Analyzer takes necessary metadata from the MagicDraw model and puts it in 
 * the intermediate data structure (@see myplugin.generator.fmmodel.FMModel) optimized
 * for code generation using freemarker. Model Analyzer now takes metadata only for ejb code 
 * generation

 * @ToDo: Enhance (or completely rewrite) myplugin.generator.fmmodel classes and  
 * Model Analyzer methods in order to support GUI generation. */ 


public class ModelAnalyzer {	
	//root model package
	private Package root;
	
	//java root package for generated code
	private String filePackage;
	
	public ModelAnalyzer(Package root, String filePackage) {
		super();
		this.root = root;
		this.filePackage = filePackage;
	}

	public Package getRoot() {
		return root;
	}
	
	public void prepareModel() throws AnalyzeException {
		FMModel.getInstance().getClasses().clear();
		FMModel.getInstance().getEnumerations().clear();
		processPackage(root, filePackage);
	}
	
	private void processPackage(Package pack, String packageOwner) throws AnalyzeException {
		//Recursive procedure that extracts data from package elements and stores it in the 
		// intermediate data structure
		
		if (pack.getName() == null) throw  
			new AnalyzeException("Packages must have names!");
		
		String packageName = packageOwner;
		if (pack != root) {
			packageName += "." + pack.getName();
		}
		
		if (pack.hasOwnedElement()) {
			
			for (Iterator<Element> it = pack.getOwnedElement().iterator(); it.hasNext();) {
				Element ownedElement = it.next();
				if (ownedElement instanceof Class) {
					Class cl = (Class)ownedElement;
					FMClass fmClass = getClassData(cl, packageName);
					FMModel.getInstance().getClasses().add(fmClass);
				}
				
				if (ownedElement instanceof Enumeration) {
					Enumeration en = (Enumeration)ownedElement;
					FMEnumeration fmEnumeration = getEnumerationData(en, packageName);
					FMModel.getInstance().getEnumerations().add(fmEnumeration);
				}								
			}
			
			for (Iterator<Element> it = pack.getOwnedElement().iterator(); it.hasNext();) {
				Element ownedElement = it.next();
				if (ownedElement instanceof Package) {					
					Package ownedPackage = (Package)ownedElement;
					if (StereotypesHelper.getAppliedStereotypeByString(ownedPackage, "BusinessApp") != null)
						//only packages with stereotype BusinessApp are candidates for metadata extraction and code generation:
						processPackage(ownedPackage, packageName);
				}
			}
			
			/** @ToDo:
			  * Process other package elements, as needed */ 
		}
	}
	
	private FMClass getClassData(Class cl, String packageName) throws AnalyzeException {
		if (cl.getName() == null) 
			throw new AnalyzeException("Classes must have names!");
		
		FMClass fmClass = new FMClass(cl.getName(), packageName, cl.getVisibility().toString());
		Iterator<Property> it = ModelHelper.attributes(cl);
		while (it.hasNext()) {
			Property p = it.next();
			if (p.getOpposite() != null) {
				FMLinkedProperty linkedProperty = getLinkedProperty(p, cl);
				linkedProperty.setName(linkedProperty.getName().replace(" ", ""));
				fmClass.addLinkedProperty(linkedProperty);
			} else {
				FMPersistentProperty prop = getPersistentProperty(p, cl);
				prop.setName(prop.getName().replace(" ", ""));
				fmClass.addProperty(prop);
			}
		}
		return fmClass;
	}

	private FMPersistentProperty getPersistentProperty(Property p, Class cl) throws AnalyzeException {
		PHelper property = getProperty(p, cl);
		Stereotype persistentStereotype = StereotypesHelper.getAppliedStereotypeByString(p, "PersistentProperty");
		String columnName = null;
		Integer precision = null;
		Boolean unique = null;
		Integer length = null;
		Boolean display = false;

		if (persistentStereotype != null) {
			List<Property> tags = persistentStereotype.getOwnedAttribute();
			for (int j = 0; j < tags.size(); ++j) {
				Property tagDef = tags.get(j);
				String tagName = tagDef.getName();
				List value = StereotypesHelper.getStereotypePropertyValue(p, persistentStereotype, tagName);
				if (value.size() > 0) {
					switch (tagName) {
						case "columnName":
							columnName = (String) value.get(0);
							break;
						case "precision":
							precision = (Integer) value.get(0);
							break;
						case "unique":
							unique = (Boolean) value.get(0);
							break;
						case "length":
							length = (Integer) value.get(0);
							break;
						case "display":
							display = (Boolean) value.get(0);
							break;
					}
				}
			}
		}


		FMPersistentProperty prop = new FMPersistentProperty(property.getAttName(), property.getTypeName(), p.getVisibility().toString(), columnName, length, unique, precision,
				property.getLower(), property.getUpper());
		prop.setDisplay(display);
		return prop;
	}

	private myplugin.helpers.PHelper getProperty (Property p, Class cl)throws AnalyzeException  {
		PHelper prop = new PHelper(p.getName(),p.getType(),p.getType().getName(),p.getLower(),p.getUpper());
		if (prop.getAttName() == null)
			throw new AnalyzeException("Properties of the class: " + cl.getName() +
					" must have names!");
		if (prop.getAttType() == null)
			throw new AnalyzeException("Property " + cl.getName() + "." +
					p.getName() + " must have type!");
		if (prop.getTypeName() == null)
			throw new AnalyzeException("Type ot the property " + cl.getName() + "." +
					p.getName() + " must have name!");
		return  prop;
	}

	private FMLinkedProperty getLinkedProperty(Property p, Class cl) throws AnalyzeException {
		PHelper property = getProperty(p,cl);
		Stereotype linkedStereotype = StereotypesHelper.getAppliedStereotypeByString(p, "LinkedProperty");
		CascadeType cascade = null;
		FetchType fetchType = null;
		String mappedBy = null;
		Boolean optional = null;
		if (linkedStereotype != null) {
			List<Property> tags = linkedStereotype.getOwnedAttribute();
			for (int j = 0; j < tags.size(); ++j) {
				Property tagDef = tags.get(j);
				String tagName = tagDef.getName();
				List value = StereotypesHelper.getStereotypePropertyValue(p, linkedStereotype, tagName);
				if (value.size() > 0) {
					switch (tagName) {
						case "cascade":
							cascade = (CascadeType) value.get(0);
							break;
						case "fetchType":
							fetchType = (FetchType) value.get(0);
							break;
						case "mappedBy":
							mappedBy = (String) value.get(0);
							break;
						case "optional":
							optional = (Boolean) value.get(0);
							break;
					}
				}
			}
		}

		int oppositeEnd = p.getOpposite().getUpper();
		FMLinkedProperty prop = new FMLinkedProperty(property.getAttName(), property.getTypeName(), p.getVisibility().toString(), null, null, null, null,
				property.getLower(), property.getUpper(), cascade, fetchType, mappedBy, optional, oppositeEnd);
		return prop;


	}

	private FMEnumeration getEnumerationData(Enumeration enumeration, String packageName) throws AnalyzeException {
		FMEnumeration fmEnum = new FMEnumeration(enumeration.getName(), packageName);
		List<EnumerationLiteral> list = enumeration.getOwnedLiteral();
		for (int i = 0; i < list.size(); i++) {
			EnumerationLiteral literal = list.get(i);
			if (literal.getName() == null)  
				throw new AnalyzeException("Items of the enumeration " + enumeration.getName() +
				" must have names!");
			fmEnum.addValue(literal.getName());
		}
		return fmEnum;
	}	
	
	
}
