:- use_module(library(jpl)).    %Importing the jpl interface which connects the prolog and java together.


start :-sleep(0.4),	            %Makes a delay of 0.4 seconds
		
		write("Running"),nl,nl,			%Writes a text to the consol		
		interface2.  			%Executing the interface2 which is responsable for taking the name




%These are the rules of the system

   

    characteristics(User,slow) :- verify(User," slow_to_boot (y/n) ?").				

    characteristics(User,restarting) :- verify(User,"computer_keeps_restarting (y/n) ?").  

    characteristics(User,bluescreen) :- verify(User," bluescreen_of_death (y/n) ?").    
  
    	   		characteristics(User,appclose) :- verify(User," apps_keep_closing_ (y/n) ?").

            characteristics(User,comnotstart) :- verify(User," computer_does_not_start (y/n) ?").  
    
  
    characteristics(User,freeze) :- verify(User," screen_freezes (y/n) ?").

    characteristics(User,noices) :- verify(User," unusual_noices (y/n) ?").

    characteristics(User,corrupted) :- verify(User," corrupted_data (y/n) ?").
    


    
    characteristics(User,pheripherals) :- verify(User," keyboard_mouse_printer_or_other_pheripheral_devices_not_working(y/n) ?").
   
    characteristics(User,internetslow) :- verify(User," internet_is_slow (y/n) ?").  

    characteristics(User,filesmissing) :- verify(User," files_missing (y/n) ?").


    characteristics(User,appsnotinstall) :- verify(User,"apps_not_installing(y/n) ?").
   
    characteristics(User,appsnotworking) :- verify(User,"apps_not_working_properly(y/n) ?").
  
    characteristics(User,comfunctions) :- verify(User," computer_functions_failing (y/n) ?").



    characteristics(User,downloadissues) :- verify(User," downloading_issues (y/n) ?").

    characteristics(User,poppus) :- verify(User,"too_many_popups_in_start (y/n) ?").

    characteristics(User,overheat) :- verify(User," computer_is_overheating (y/n) ?").



       
	
	

%These are the rules of the system 

    hypothesis(User,problem_in_RAM_card) :-					
        characteristics(User,slow),
        characteristics(User,restarting),
        characteristics(User,bluescreen),
        characteristics(User,appclose),
        characteristics(User,comnotstart),
        characteristics(User,freeze).

    hypothesis(User,failing_hard_disk) :- 
        characteristics(User,slow),
        characteristics(User,noices),
        characteristics(User,bluescreen),
        characteristics(User,restarting),
        characteristics(User,corrupted).
        
    hypothesis(User,problem_in_graphics_card_motherboard_or_network_card_drives) :-
        
        characteristics(User,freeze),
        characteristics(User,restarting),
        characteristics(User,pheripherals),
        characteristics(User,internetslow),
        characteristics(User,bluescreen).  
        
    hypothesis(User,os_updating_problem_adware_virus_or_malware) :-
        
        characteristics(User,slow),
        characteristics(User,bluescreen),
        characteristics(User,freeze),
        characteristics(User,corrupted),
        characteristics(User,filesmissing),
        characteristics(User,appsnotinstall),
        characteristics(User,appsnotworking),
        characteristics(User,comfunctions).
        
    hypothesis(User,driver_issues) :-
        
        characteristics(User,slow),
        characteristics(User,pheripherals),
        characteristics(User,bluescreen),
        characteristics(User,freeze).
    
    hypothesis(User,background_apps_consuming_the_bandwith) :-
        
        characteristics(User,internetslow),
        characteristics(User,downloadissues).

         hypothesis(User,too_many_startup_programs) :-
        
        characteristics(User,restarting),
        characteristics(User,slow),
        characteristics(User,poppus).


         hypothesis(User,problem_in_processor_fans_or_cooling_system) :-
        
        characteristics(User,noices),
        characteristics(User,overheat).

         hypothesis(User,port_issues_or_component_issues) :-
    
        characteristics(User,pheripherals).




	hypothesis(_,"Laptop. yet there is no any reason in my knowledge base with that characteristics.. :(").
	
    response(Reply) :-
        read(Reply),
        write(Reply),nl.
		
ask(User,Question) :-
	write(User),write(', do you have following problems:'),write(Question),	
	interface(', do you have following problems: ',User,Question),nl.
	
:- dynamic yes/1,no/1.		
	
verify(P,S) :-
   (yes(S) 
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(P,S))).
	 
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.


pt(User):- 

		hypothesis(User,Reason),
		interface3(User,', The reason maybe: ',Reason,'.'),
        write(User),write(', The reason maybe '),write(Reason),write('.'),nl,nl,
undo,end.



		

		
 		

end :-
		nl,nl,nl,
		sleep(0.4),
		write("Shutting Down"),nl.

interface(X,Y,Z) :-			%Asks the Questions
	atom_concat(Y,X, FAtom),  %atom_concat(?Atom1, ?Atom2, ?Atom3)  Atom3 forms the concatenation of Atom1 and Atom2.
	atom_concat(FAtom,Z,FinalAtom),
	jpl_new('javax.swing.JFrame', ['Troubleshooter'], F),									%F is the frame
	jpl_new('javax.swing.JLabel',['Find your Solution'],LBL),
	jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
	jpl_call(F, setLocation, [400,300], _),
	jpl_call(F, setSize, [400,300], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
	jpl_call('javax.swing.JOptionPane', showInputDialog, [F,FinalAtom], N),						%N will hold either y or n		
	jpl_call(F, dispose, [], _), 
	write(N),nl,
	( (N == yes ; N == y)
      ->
       assert(yes(Z)) ;
       assert(no(Z)), fail).
	   		
interface2 :-				%Takes the name
	jpl_new('javax.swing.JFrame', ['Troubleshooter'], F),
	jpl_new('javax.swing.JLabel',['Find your Solution'],LBL),
	jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
	jpl_call(F, setLocation, [400,300], _),
	jpl_call(F, setSize, [400,300], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
	jpl_call('javax.swing.JOptionPane', showInputDialog, [F,'Hello User.. Please tell me your name'], N),		%N will hold the entered name
	jpl_call(F, dispose, [], _), 
	/*write(N),nl,*/
	(	N == @(null)				%null only happens when we cancel button is clicked, if nothing was entered it will be considered empty String ""
		->	write('You cancelled'),interface3('You cancelled. ','Thank you ','for using ','Troubleshooter.'),end,fail
		;	write("Hello User.. Please tell me your name : "),nl,pt(N)
	).
	
	
interface3(P,W1,D,W2) :-				
	atom_concat(P,W1, A),    
	atom_concat(A,D,B),
	atom_concat(B,W2,W3),
	jpl_new('javax.swing.JFrame', ['Troubleshooter'], F),
	jpl_new('javax.swing.JLabel',['Find your Solution'],LBL),
	jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
	jpl_call(F, setLocation, [400,300], _),
	jpl_call(F, setSize, [400,300], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
	jpl_call('javax.swing.JOptionPane', showMessageDialog, [F,W3], N),			%F is the frame			W3 is the message
	jpl_call(F, dispose, [], _), 
	/*write(N),nl,*/
	(	N == @(void)			%Exeption handling
		->	write('')
		;	write("")

	).



help :- write("To start type 'start.' and press Enter").