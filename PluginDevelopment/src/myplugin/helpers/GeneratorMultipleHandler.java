package myplugin.helpers;

import freemarker.template.TemplateException;
import myplugin.generator.BasicGenerator;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;

import javax.swing.*;
import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GeneratorMultipleHandler extends BasicGenerator {
    public GeneratorMultipleHandler(GeneratorOptions generatorOptions) {
        super(generatorOptions);
    }

    public void generate() {
        try {
            super.generate();
        } catch (IOException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        }

        List<FMClass> classes = FMModel.getInstance().getClasses();
        Map<String, Object> context = new HashMap<String, Object>();
        Map<String, Object> allProperties = new HashMap<String, Object>();
        try {
            Writer out = getWriter("", this.getFilePackage());
            if (out != null) {
                context.clear();
                context.put("classes", classes);
                for (int i = 0; i < classes.size(); i++) {
                    FMClass cl = classes.get(i);
                    allProperties.put(cl.getName(), cl.getProperties());
                }
                context.put("allProperties", allProperties);
                getTemplate().process(context, out);
                out.flush();
            }
        } catch (TemplateException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        } catch (IOException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
    }
}
