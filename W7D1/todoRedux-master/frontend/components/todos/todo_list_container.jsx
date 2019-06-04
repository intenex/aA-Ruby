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
const mapDispatchToProps = (dispatch) => ({
  receiveTodo: todo => dispatch(receiveTodo(todo)) // look more into how this thing has access to the receiveTodo function just globally like this think through it a little bit later for sure. A lot to think through and work with for sure right now man definitely do it all.
});

// this creates a connected component that can access state lower down in components without needing prop-threading and state prop-threading to have the state passed down as a prop manually to each child component right this allows you to create a connected Component that can transform implicit context into props yep love it
export default connect(mapStateToProps, mapDispatchToProps)(TodoList); // right because it's an export default you can call it whatever you want arbitrarily wherever you import it dope

// lol they literally keep telling you the answers but you keep doing it just fine on your own dope