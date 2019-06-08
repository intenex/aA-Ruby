import { connect } from 'react-redux';
import TodoList from './todo_list';
import { allTodos } from '../../reducers/selectors';

// container components do actually all the hard work of the logic behind the scenes

const mapStateToProps = (state, ownProps) => ({ // implicit object return fat arrow function dope // right love it as long as no brackets around it so great
  todos: allTodos(state) // awesome using the selector here dope --> this creates a property that is set to all the todos awesome
});

// right look more into how mapDispatchToProps is supposed to work
// ahh you map dispatch calls to props so if you call the property receiveTodo and pass it a todo it'll invoke a call to dispatch with the action from the receiveTodo action creator nuts
// yeahhh not clear how this has access to receiveTodo really strange lol damn look into this more for sure
// weird that this works without importing '../../actions/todo_actions' where the receiveTodo is stored or maybe it doesn't work lol look into it more
const mapDispatchToProps = (dispatch) => ({
  receiveTodo: todo => dispatch(receiveTodo(todo)), // look more into how this thing has access to the receiveTodo function just globally like this think through it a little bit later for sure. A lot to think through and work with for sure right now man definitely do it all.
  removeTodo: todo => dispatch(removeTodo(todo)) // seriously how does this have access to this man
});

// this creates a connected component that can access state lower down in components without needing prop-threading and state prop-threading to have the state passed down as a prop manually to each child component right this allows you to create a connected Component that can transform implicit context into props yep love it
// yep the TodoListContainer is just a connected component that connects the TodoList
// ah yes it destructures getting the props it wants from the prop object it's passed
// it's passed the prop object and in there we have
// prop = {todos: {}, receiveTodo: {}}
// and it just pulls those out fucking love it
// and receiveTodo is a function that takes in a todo and then invokes the dispatch function and passes it an action that's created with the receiveTodo action creator being passed the todo fucking love it man
export default connect(mapStateToProps, mapDispatchToProps)(TodoList); // right because it's an export default you can call it whatever you want arbitrarily wherever you import it dope

// lol they literally keep telling you the answers but you keep doing it just fine on your own dope