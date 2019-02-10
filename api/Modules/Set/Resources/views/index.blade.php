@extends('set::layouts.master')

@section('content')
    <h1>Hello World</h1>

    <p>
        This view is loaded from module: {!! config('set.name') !!}
    </p>
@stop
