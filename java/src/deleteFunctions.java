package refugee_reg_db_mg;

import refugee_reg_db_mg.Main;
import refugee_reg_db_mg.refugeeDelete;
import refugee_reg_db_mg.volunteerDelete;
import refugee_reg_db_mg.instituteDel;
import refugee_reg_db_mg.eduoccDelete;
import refugee_reg_db_mg.docnuroffDelete;
import refugee_reg_db_mg.checkupDelete;
import refugee_reg_db_mg.ComplaintDelete;

import java.sql.Connection;

import javafx.event.ActionEvent;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.stage.Stage;

public class deleteFunctions {
    static Connection con;
    public  static Stage primaryStage ;
    public static void selectTable() {
        primaryStage = Main.primaryStage;
            Label title= new Label("Select for deletion");
            title.setTextFill(Color.WHITE);
            title.setUnderline(true);
            title.setFont(Font.font("Castellar", FontWeight.BOLD, 40));
            BorderPane root = new BorderPane();
            root.setId("background-one");
            
            
            //Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
            Scene scene1 = new Scene(root, 1100, 900);
            scene1.getStylesheets().add(deleteFunctions.class.getResource("css/css1.css").toExternalForm());
            GridPane gridg = new GridPane();
            gridg.add(title, 0, 0);
            gridg.setAlignment(Pos.CENTER);
            gridg.setHgap(10);
            gridg.setVgap(40);
            gridg.setPadding(new Insets(25, 25, 25, 25));
            
            Button rb= new Button("Refugee");
            rb.setId("com-button");
            //rb.setPrefSize(400, 50);
            gridg.add(rb, 0, 1);
            rb.setOnAction((ActionEvent event) -> {
                refugeeDelete.frstnm=null;
                refugeeDelete.lastnm= null;
                refugeeDelete.delete();
            }); 
            Button vb= new Button("Volunteer");
            vb.setId("com-button");
            //vb.setPrefSize(400, 50);
            gridg.add(vb, 0, 2);
            vb.setOnAction((ActionEvent event) -> {
                volunteerDelete.frstnm=null;
                volunteerDelete.lastnm=null;
                volunteerDelete.delete();
            }); 
            Button ib= new Button("Institute");
            ib.setId("com-button");
            gridg.add(ib, 0, 3);
            ib.setOnAction((ActionEvent event) -> {
                instituteDel.delete();
            }); 
            Button eb= new Button("Educational/Occupational Info");
            eb.setId("com-button");
            //eb.setPrefSize(400, 50);
            gridg.add(eb, 0, 4);
            eb.setOnAction((ActionEvent event) -> {
                eduoccDelete.delete();
            }); 
            Button dnob= new Button("Doctor/Nurse/Officer");
            dnob.setId("com-button");
            //cb.setPrefSize(400, 50);
            gridg.add(dnob, 0, 5);
            dnob.setOnAction((ActionEvent event) -> {
                docnuroffDelete.delete();
            });
            Button chb= new Button("Checkup History");
            chb.setId("com-button");
            //cb.setPrefSize(400, 50);
            gridg.add(chb, 0, 6);
            chb.setOnAction((ActionEvent event) -> {
                checkupDelete.docid = null;
                checkupDelete.refid = null;
                checkupDelete.docname = null;
                checkupDelete.delcheck();
            });
            Button cb= new Button("Complaint");
            cb.setId("com-button");
            //cb.setPrefSize(400, 50);
            gridg.add(cb, 0, 7);
            cb.setOnAction((ActionEvent event) -> {
                ComplaintDelete.comdel(Main.conn.con);
            });
            
            Button back , next;
            back = new Button("");
            back.setId("back-one");
            back.setPrefSize(120, 40);
            back.setOnAction((ActionEvent event) -> {
                Main.AuthorityHomePage();
            });
            
            gridg.add(back, 0, 8);
            root.setCenter(gridg);
            
            primaryStage.setScene(scene1);
    }

}
